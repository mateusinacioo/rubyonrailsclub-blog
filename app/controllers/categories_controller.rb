# frozen_string_literal: true

class CategoriesController < ApplicationController

  def all_categories
    @categories = Category.all
  end
end
