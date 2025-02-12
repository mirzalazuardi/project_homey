module Crudable
  extend ActiveSupport::Concern
  include TurboStreamResponses

  included do
    before_action :set_resource, only: [:show, :edit, :update, :destroy]
  end

  def index
    @q = resource_class.ransack(params[:q])
    @pagy, @resources = pagy(@q.result)

    params[:q].each do |key, value|
      cookies[key] = value
    end if params[:q]
  end
  alias_method :search, :index

  def new
    @resource = resource_class.new
  end

  def create
    @resource = resource_class.new(resource_params)
    if @resource.save
      respond_to do |format|
        format.html { redirect_to @resource,
                      notice: "#{resource_class.name} was successfully created." }
        format.turbo_stream { render turbo_stream: create_success_turbo_streams }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: create_failure_turbo_streams }
      end
    end
  end

  def update
    if @resource.update(resource_params)
      respond_to do |format|
        format.html { redirect_to @resource,
                      notice: "#{resource_class.name} was successfully updated." }
        format.turbo_stream { render turbo_stream: update_success_turbo_streams }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: update_failure_turbo_streams }
      end
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url,
                    notice: "#{resource_class.name} was successfully destroyed." }
      format.turbo_stream { render turbo_stream: destroy_turbo_streams }
    end
  end

  private

  def set_resource
    @resource = resource_class.find(params[:id])
  end

end

