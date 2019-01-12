# frozen_string_literal: true

# API for creating page layouts for events
class Api::V1::PageLayoutsController < ApiController
  before_action :set_layout, only: [:show, :update, :destroy]

  # GET /page_layouts
  def index
    # paginate = pagination_params(params)
    team_ids = current_team

    results = search_layouts(team_ids, params[:order_by], params[:page_layout_type])
    layouts = ActiveModelSerializers::SerializableResource.new(results)
    render_success(layouts)
    #respond_with results, each_serializer: PageLayoutSerializer #, meta: pagination_dict(results)
  end

  # GET /page_layouts/1
  # GET /page_layouts/1.json
  def show
    render_success PageLayoutSerializer.new(@layout).as_json
  end

  # POST /page_layouts
  # POST /page_layouts.json
  def create
    @layout = PageLayout.new(page_layout_params)
    @layout.is_original = false
    if @layout.save
      render_success(PageLayoutSerializer.new(@layout).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @layout.errors.full_messages.join(","),
                   @layout.errors)
    end
  end

  # PATCH/PUT /page_layouts/1
  # PATCH/PUT /page_layouts/1.json
  def update
    if @layout.update_attributes(page_layout_params)
      render_success(PageLayoutSerializer.new(@layout).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @layout.errors.full_messages.join(","),
                   @layout.errors)
    end
  end

  # DELETE /page_layouts/1
  # DELETE /page_layouts/1.json
  def destroy
    if @page_layout.destroy
      render_success(success: true)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @layout.errors.full_messages.join(","),
                   @layout.errors)
    end
  end

  private

  def search_layouts(team_ids, order_by, page_layout_type)
    case page_layout_type
    when "original"
      PageLayout.templates.where(team_id: team_ids).order(order_by)
    else
      PageLayout.saved.where(team_id: team_ids).order(order_by)
    end
  end

  def set_layout
    @layout = PageLayout.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_layout_params
    params.require(:page_layout).permit(:team_id, :is_original, :header, :sidebar, :body, :footer,
                                        :name, :disable_sidebar)
  end
end
