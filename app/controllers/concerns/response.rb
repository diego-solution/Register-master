# frozen_string_literal: true

# formats responses for API
module Response
  extend ActiveSupport::Concern

  # render a json response with a success format
  def render_success(json, extra_meta = {})
    response = { code: RESPONSE_CODE[:success], message: "success", data: json }.merge(extra_meta)
    json_response response.as_json, RESPONSE_CODE[:success]
  end

  # render a json response with a error format
  def render_error(code, message, debug_info = "")
    response = { code: code, message: message, debug_info: debug_info, data: nil }
    json_response response.as_json, code
  end

  # render a json for pagination
  def pagination_dict(object)
    {
      pagination: {
        current_page: object.current_page,
        next_page: object.next_page || -1,
        prev_page: object.prev_page || -1,
        total_pages: object.total_pages,
        total_count: object.total_count,
        per_page: object.limit_value
      }
    }
  end

  def pagination_params(params)
    page     = (params[:page] || 1).to_i
    per_page = (params[:per_page] || PER_PAGE).to_i
    order_by = (params[:order_by] || "created_at DESC")
    {
      page: page,
      per_page: per_page,
      order_by: order_by
    }
  end

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
