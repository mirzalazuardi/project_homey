module TurboStreamResponses
  extend ActiveSupport::Concern
  include ActionView::RecordIdentifier

  protected

  def default_create_success_turbo_streams
    result = [
      turbo_stream.prepend(pluralized_resource, partial: "#{pluralized_resource}/#{underscored_resource}", locals: { resource: @resource }),
    ]
    result
  end

  def default_create_failure_turbo_streams
    result = [
      turbo_stream.replace(dom_id(@resource, :error_create), partial: "shared/error_crud", locals: { resource: @resource }),
    ]
    result
  end

  def default_update_success_turbo_streams
    result = [
      turbo_stream.replace(dom_id(@resource), partial: "#{pluralized_resource}/#{underscored_resource}", locals: { resource: @resource }),
    ]
    result
  end

  def default_update_failure_turbo_streams
    result = [
      turbo_stream.replace(dom_id(@resource, :error_update), partial: "shared/error_crud", locals: { resource: @resource }),
    ]
    result
  end

  def default_destroy_turbo_streams
    result = [
      turbo_stream.remove(@resource),
    ]
    result
  end

  # Methods to customize Turbo Stream actions
  def append(target, partial, locals = {})
    turbo_stream.append(target, partial: partial, locals: locals)
  end

  def replace(target, partial, locals = {})
    turbo_stream.replace(target, partial: partial, locals: locals)
  end

  def remove(target)
    turbo_stream.remove(target)
  end

  def create_success_turbo_streams
    default_create_success_turbo_streams
  end

  def create_failure_turbo_streams
    default_create_failure_turbo_streams
  end

  def update_success_turbo_streams
    default_update_success_turbo_streams
  end

  def update_failure_turbo_streams
    default_update_failure_turbo_streams
  end

  def destroy_turbo_streams
    default_destroy_turbo_streams
  end
end

