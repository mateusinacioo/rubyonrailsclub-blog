# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @articles = Article.includes(:category, :author).all.limit(6)
    # Para evitar o N+1 é adicionado o includes
  end
end
