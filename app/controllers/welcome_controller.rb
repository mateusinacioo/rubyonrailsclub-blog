# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @articles = Article.all.limit(6)
  end
end
