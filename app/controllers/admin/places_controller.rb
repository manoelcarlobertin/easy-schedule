class Admin::PlacesController < ApplicationController
  before_action :authenticate_user!
end
