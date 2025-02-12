# app/controllers/versions_controller.rb
class VersionsController < ApplicationController
  before_action :set_item_type, only: %i[index]

  def index
    @versions = item_class
      .v_item_type(item_class.name)
    @versions = @versions.where(item_id: params[:item_id]) if params[:item_id]
  end

  def show
    @version = PaperTrail::Version.find(params[:id])
    @resource = @version.item
  end

  private

  attr_reader :item_class

  def set_item_type
    @item_class = params[:item_type].classify.constantize
  end
end
