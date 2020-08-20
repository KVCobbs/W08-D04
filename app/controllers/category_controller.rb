class CategoryController < ApplicationController

  def index
    @category = Category.all

    if @category.empty?
      render json: {
          'error': 'Nothing to see here'
      }
    else
      render :json => {
          :response => 'Success!',
          :data => @category
      }
    end
  end

  def create
    @one_category = Category.new(category_params)
    if @one_category.save
      render :json => {
          :response => 'Success!',
          :data => @one_category
      }
    else
      render :json => {
          :error => 'Uh-Oh'
      }
    end
    end

    def update
      if(@single_category_update = Category.find_by_id(params[:id])).present?
        @single_category_update.update(category_params)
        render :json => {
            :response => 'Success!',
            :data => @single_category_update
        }
      else
        render :json => {
            :response => 'We cant update the record'
        }
      end
    end

  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => 'Success!',
      :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => 'Uh-Oh Stinky!'
      }
    end
  end

  def destroy
    if(@category_delete = Category.find_by_id(params[:id])).present?
    @category_delete.destroy
    render :json => {
        :response => 'Success!'
    }
    else
      render :json => {
          :response => 'Uh Oh Stinky!'
      }
    end
  end


  private
  def category_params
    params.permit( :id, :title, :description, :created_by )
  end

end
