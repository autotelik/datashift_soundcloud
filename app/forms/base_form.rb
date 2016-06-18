require_dependency "reform"

class BaseForm < Reform::Form
  include ActionView::Helpers::TranslationHelper
  include ActiveModel::Validations

  feature Reform::Form::ActiveModel::Validations


  def initialize(client)
    super(client)
  end

  def validate(params)
    super params.fetch(params_key, {})
  end

  def view_path
    :show
  end

  protected

  def logger
    Rails.logger
  end
end
