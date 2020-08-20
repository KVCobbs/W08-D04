class RecipesController < ApplicationController

    def index
      @recipe = Recipe.where({category:params[:category_id]})
      if @recipe.empty?
        render :json => {
            :error => "Uh-oh Stinky!"
        }
      else
        render :json => {
            :response => "Success!",
            :data => @recipe
        }
      end
    end


    def create
      @new_recipe_item = Recipe.new(recipe_params)
      if Category.exists?(@new_recipe_item.category_id)
        if @new_recipe_item.save
          render :json => {
              :response => "Success!",
              :data => @new_recipe_item
          }
        else
          render :json => {
              :response => "Uh-Oh Stinky!"
          }
        end
      else
        render :json => {
            :error => 'Gross! Stinky!'
        }
      end
    end


    def show
      @single_recipe=Recipe.exists?(params[:id])
      if @single_recipe
        render :json => {
            :response => "Success!",
            :data => Recipe.find(params[:id])
        }
      else
        render :json => {
            :error => "Uh-Oh Stinky"
        }
      end
    end

    def update
      if (@single_recipe = Recipe.find_by_id(params[:id])).present?
        @single_recipe.update(recipe_params)
        render :json => {
            :response => "Success!",
            :data => @single_recipe
        }
      else
        render :json => {
            :error => "Uh-Oh Stinky"
        }
      end
    end

    def destroy
      if (@single_recipe_destroy = Recipe.find_by_id(params[:id])).present?
        @single_recipe_destroy.destroy
        render :json => {
            :response => "Success!",
            :data => @single_recipe_destroy
        }
      else
        render :json => {
            :error => "Uh-Oh Stinky!"
        }
      end
    end

    private
    def recipe_params
      params.permit(:category_id, :name, :directions, :ingredients)
    end
  end
