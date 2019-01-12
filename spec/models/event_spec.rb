# frozen_string_literal: true

RSpec.describe Event, type: :model do
  context ".create" do
    let(:event) { FactoryBot.create :event_blank }

    it "should add default content" do
      expect(PageContent.all.count).to eq 0
      expect(PageLayout.all.count).to eq 0
      expect(event.save).to be true
      expect(PageContent.all.count).to eq 1
      expect(event.registration_form).not_to be nil
    end
  end

  context ".destroy" do
    let!(:event) { FactoryBot.create :event }
    let!(:registrant) { FactoryBot.create :registrant, event: event }
    let!(:referrer) { FactoryBot.create :referrer, event: event }
    let!(:referrer2) { FactoryBot.create :referrer, email: "coco@think.pt", event: event }

    it "should not remove ongoing events" do
      event.registration_start_date = Time.zone.now - 1.day
      event.registration_close_date = Time.zone.now + 5.days
      expect(event.destroy).to be false
    end

    it "should delete everything", versioning: true  do
      event_id = event.id
      expect(event.registrants.count).to eq 1
      expect(event.page_content).not_to be nil
      expect(event.referrers.count).to eq 2
      expect(event.id).not_to be nil
      Event.transaction do
        expect(event.destroy).not_to be nil
      end
      expect(Event.find_by(id: event_id)).to be nil
      expect(Referrer.all.count).to eq 0
      expect(PageContent.all.count).to eq 0
    end

    it "should revert registrant", versioning: true  do
      reg_id = registrant.id
      registrant.destroy
      version = PaperTrail::Version.where(event: 'destroy', item_type: 'Registrant').last
      version.reify.save!
      registrant = Registrant.find_by(id: reg_id)
      expect(registrant.id).not_to be nil
      expect(registrant.email_hash).not_to be nil
      expect(registrant.event_id).to eq event.id
    end

    it "should revert everything", versioning: true  do
      expect(PaperTrail).to be_enabled
      event_id = event.id
      #Event.transaction do
        event.destroy
      #end
      #Event.transaction do
        version = PaperTrail::Version.where(event: 'destroy', item_type: 'Event').last
        version.reify(has_one: true, has_many: true).save!
      #end
      event = Event.find_by(id: event_id)
      expect(event.page_content).not_to be nil
      expect(event.referrers.count).to eq 2
      expect(event.registrants.count).to eq 1
      expect(event.id).not_to be nil
    end
  end

  context ".full?" do
    let!(:event) { FactoryBot.create :event }
    let(:registrant) { FactoryBot.create :registrant, event: event }

    it "should return true if capacity 0" do
      event.capacity = 0
      expect(event.full?).to be true
    end

    it "should return false if capacity not full" do
      registrant.confirm!
      expect(event.full?).to be false
    end
  end

  context "time zones" do
    let!(:event) { FactoryBot.create :event }

    it "should save dates in utc" do
      expect(event.event_start_date.time_zone.to_s).to eq "(GMT+00:00) UTC"
      expect(event.event_end_date.time_zone.to_s).to eq "(GMT+00:00) UTC"
    end

    it "should convert given date and store as utc" do
      start_date = nil
      Time.use_zone("Europe/Lisbon") do
        start_date = Time.current
      end
      event.event_start_date = start_date
      event.save
      start_date_utc = ActiveSupport::TimeZone["Etc/UTC"].parse start_date.to_s

      expect(event.event_start_date.time_zone.to_s).to eq "(GMT+00:00) UTC"
      expect(event.event_start_date.to_s).to eq start_date_utc.to_s
    end

    it "should use given time_zone in layout html" do
      start_date_tz = nil
      Time.use_zone(event.time_zone) do
        start_date_tz = event.event_start_date
      end
      expect(event.page_content.sidebar_html).to match start_date_tz.to_s(:year_month_day_no_time)
    end
  end
end
