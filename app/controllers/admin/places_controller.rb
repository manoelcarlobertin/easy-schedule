class Admin::PlacesController < ApplicationController
  before_action :authenticate_user!

  def index
    @places = Place.all
  end
end
