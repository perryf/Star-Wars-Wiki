class PagesController < ApplicationController
  def index
  end
  def show
  end

  # You actually don't need to define a controller method if there isn't any data being
  # loaded in and the name of the view file matches the name specified in your routes
  # (i.e. index can be inferred)
end
