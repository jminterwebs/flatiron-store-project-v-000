class CategoriesController < ApplicationController

  def show
    # binding.pry
    @category = Category.all
  end

end
