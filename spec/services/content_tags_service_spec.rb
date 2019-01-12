# frozen_string_literal: true

describe ContentTagsService do
  context "when parsing tags" do
    let!(:event) { FactoryBot.create :event }

    it "should replace with something else " do
      service = ContentTagsService.new(event: event)
      expect(service.replace_tags("{{event.name}}")).to eq event.public_name
    end

    it "should replace with something else 2x " do
      service = ContentTagsService.new(event: event)
      expect(service.replace_tags("{{event.name}} {{event.name}}"))
        .to eq "#{event.public_name} #{event.public_name}"
    end

    it "should not be empty if doesnt exist" do
      service = ContentTagsService.new(event: event)
      expect(service.replace_tags("coco")).to eq "coco"
    end

    it "should not replace if tag is wrong" do
      service = ContentTagsService.new(event: event)
      expect(service.replace_tags("{{event.coco}}")).to eq "{{event.coco}}"
    end
  end
end
