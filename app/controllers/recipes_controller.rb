class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :vote_up, :vote_down]

  def index
    @recipes = ordered_recipes
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        @recipes = ordered_recipes
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
        format.js   { render :create }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
        format.js   { render :new }
      end
    end
  end

  def vote_up
    previous_votes = []
    previous_votes = JSON.parse(cookies[:votes]) if cookies[:votes]
    unless previous_votes.include?(@recipe.id)
      Vote.create!(recipe: @recipe, up: true)
      cookies[:votes] = JSON.generate(previous_votes << @recipe.id)
    end

    @recipes = ordered_recipes

    respond_to do |format|
      format.html { redirect_to :back }
      format.js   { render 'vote' }
    end
  end

  def vote_down
    previous_votes = []
    previous_votes = JSON.parse(cookies[:votes]) if cookies[:votes]
    unless previous_votes.include?(@recipe.id)
      Vote.create!(recipe: @recipe, up: false)
      cookies[:votes] = JSON.generate(previous_votes << @recipe.id)
    end

    @recipes = ordered_recipes

    respond_to do |format|
      format.html { redirect_to :back }
      format.js   { render 'vote' }
    end
  end

  private
    def ordered_recipes
      @recipes = Recipe.all.sort_by(&:rank).reverse
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :submitter, :url)
    end
end
