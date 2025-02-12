class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pagy::Backend

  before_action :set_current_request_details
  before_action :authenticate
  before_action :set_paper_trail_whodunnit

  def pluralized_resource
    underscored_resource.pluralize
  end
  helper_method :pluralized_resource

  def underscored_resource
    resource_class.to_s.underscore
  end
  helper_method :underscored_resource

  def resource_class
    controller_name.classify.constantize
  end

  def resource_params
    params.require(controller_name.singularize.to_sym).permit!
  end

  def resources_url
    url_for(controller: controller_name, action: :index)
  end

  private
    def authenticate
      if session_record = Session.find_by_id(cookies.signed[:session_token])
        Current.session = session_record
      else
        redirect_to sign_in_path
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def user_for_paper_trail
      Current.user&.email || "Guest"
    end
end
