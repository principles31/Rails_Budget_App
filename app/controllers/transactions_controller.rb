class TransactionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_transaction, only: %i[edit update destroy]

  def index
    @category = Category.find(params[:category_id])
    @transaction = Transaction.where(category_id: params[:category_id]).order(created_at: :desc)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    @category = Category.where(user_id: current_user.id)
  end

  def create
    @user = current_user
    @transaction = @user.transactions.new(transaction_params)
    if @transaction.save
      flash[:notice] = 'Transaction sucessfully created!'
      redirect_to user_category_transactions_path(@user)
    else
      flash[:alert] = 'Transaction could not be be created!'
      render :new
    end
  end

  def destroy
    # puts plain: params
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    flash[:notice] = 'Transaction was successfully deleted.'
    redirect_to user_category_transactions_path
  end

  private

  def set_transaction
    @transaction = Transaction.includes(:user, :categories).find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :category_id, :user_id)
  end
end
