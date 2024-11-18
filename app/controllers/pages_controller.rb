class PagesController < ApplicationController
  def home
    @product = Product.new
  end
end
