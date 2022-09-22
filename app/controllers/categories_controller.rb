class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.includes(:user, :transactions).order(created_at: :desc)
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id

    if @category.save
      flash[:notice] = 'Category successfully created!'
      redirect_to user_categories_path(@category.user_id)
    else
      flash[:notice] = 'An error occured while adding a category!'
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
