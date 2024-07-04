# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    before_action :set_category, only: [:show, :edit, :update, :destroy, :destroy_cover_image]
    #   before_action :set_categories, only: [:edit, :new, :show]

    # GET /categories or /categories.json
    def index
      @categories = Category.all
    end

    # GET /categories/1 or /categories/1.json
    def show
    end

    # GET /categories/new
    def new
      @category = Category.new
    end

    # GET /categories/1/edit
    def edit
    end

    # POST /categories or /categories.json
    def create
      @category = Category.new(category_params)
      @category.cover_image.attach(category_params[:cover_image])

      respond_to do |format|
        if @category.save
          format.html { redirect_to(administrate_category_url(@category), notice: "Categoria criada com sucesso!") }
          format.json { render(:show, status: :created, location: @category) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /categories/1 or /categories/1.json
    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to(administrate_category_url(@category), notice: "Artigo atualizado com sucesso!") }
          format.json { render(:show, status: :ok, location: @category) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /categories/1 or /categories/1.json
    def destroy
      respond_to do |format|
        format.html do
          if @category.articles.count > 0
            redirect_to(
              administrate_categories_url,
              alert: "Existem Artigos associados a essa categoria! Não é possível apagá-la!",
            )
          else
            @category.destroy!
            redirect_to(administrate_categories_url, alert: "Categoria apagada com sucesso!")
          end
        end
        format.json { head(:no_content) }
      end
    end

    def destroy_cover_image
      @category.cover_image.purge

      respond_to do |format|
        format.turbo_stream { render(turbo_stream: turbo_stream.remove(@category)) }
      end
    end

    private

    def set_categories
      @categories = Category.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :cover_image)
    end
  end
end
