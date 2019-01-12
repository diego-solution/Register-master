# frozen_string_literal: true

# API for creating event/page content
class Api::V1::PageContentsController < ApiController
  before_action :set_event
  before_action :set_page_content, only: [:show, :update]

  # GET /events/2/page_contents/new
  def new
    @page_content = PageContent.init_from_page_layout(params[:page_layout_id])
    @page_content.event = @event
    render_success(PageContentSerializer.new(@page_content).as_json)
  end

  # GET /events/2/page_contents/23
  def show
    render_success PageContentSerializer.new(@page_content).as_json
  end

  # POST /events/2/page_contents
  def create
    @page_content = find_existing_or_new_page_content

    if @page_content.save
      render_success(PageContentSerializer.new(@page_content).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @page_content.errors.full_messages.join(","),
                   @page_content.errors)
    end
  end

  # PATCH/PUT /events/2/page_contents/23
  def update
    if @page_content.update_attributes(page_content_params)
      render_success(PageContentSerializer.new(@page_content).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @page_content.errors.full_messages.join(","),
                   @page_content.errors)
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_page_content
    @page_content = PageContent.find(params[:id])
  end

  def find_existing_or_new_page_content
    page = PageContent.find_by(event_id: @event.id)
    if page
      page.assign_attributes(page_content_params)
    else
      page = PageContent.new(page_content_params)
    end
    page.team  = @event.team
    page.event = @event
    page
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_content_params
    params.require(:page_content).permit(:page_layout_id, :header, :sidebar, :body,
                                         :footer, :name, :disable_sidebar)
  end
end
