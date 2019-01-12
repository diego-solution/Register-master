# frozen_string_literal: true

# returns all languages available in the app
class Api::V1::LanguagesController < ApiController
  # GET /languages
  def index
    paginate = pagination_params(params)

    data = Language.all.order(paginate[:order_by]).page(paginate[:page]).per(paginate[:per_page])

    list = ActiveModelSerializers::SerializableResource.new(data)
    render_success(list, pagination_dict(data))
  end

  # GET /languages/1
  def show
    @language = Language.find_by(id: params[:id]) || Language.find_by(key: params[:id])
    render_success(@language.as_json)
  end

end
