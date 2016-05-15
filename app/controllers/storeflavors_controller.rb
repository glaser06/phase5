class StoreFlavorsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:edit,:update,:destroy,:new]
  
  def index
    # @upcoming_shifts = StoreFlavor.upcoming.chronological.paginate(page: params[:page]).per_page(10)
    # @past_shifts = StoreFlavor.past.chronological.paginate(page: params[:page]).per_page(10)  
  end

  def show
    
  end

  def new
    @store_flavor = StoreFlavor.new
  end

  def edit
  end

  def create
    @store_flavor = StoreFlavor.new(shift_params)
    
    if @store_flavor.save
      redirect_to shift_path(@store_flavor), notice: "Successfully created store_flavor."
    else
      render action: 'new'
    end
  end

  def update
    if @store_flavor.update(shift_params)
      redirect_to shift_path(@store_flavor), notice: "Successfully updated store_flavor."
    else
      render action: 'edit'
    end
  end

  def destroy
    @store_flavor.destroy
    redirect_to shifts_path, notice: "Successfully removed store_flavor from the AMC system."
  end

  private
  def set_shift
    @store_flavor = StoreFlavor.find(params[:id])
  end

  def shift_params
    params.require(:store_flavor).permit(:store_id,:flavor_id, :active)
  end

end