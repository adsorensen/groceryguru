class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  
  def index
    @carts = Cart.all
  end
  
  def show
  end
  
  def new
    @cart = Cart.new
  end
  
  def edit
  end
  
  def create
    @cart = Cart.new(:user => params[:user], :recipe => params[:recipe])
  
    respond_to do |format|
      if @cart.save
        format.html { redirect_to '/cart'}
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @cart.destroy
    respond_to do |format|
      # format.html { redirect_to '/cart', notice: 'Cart was successfully destroyed.' }
      format.html { redirect_to '/cart'}
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:user, :recipe)
    end
end
