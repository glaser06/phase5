class StoreFlavorsController < ApplicationController
  before_action :set_store_flavor, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:edit,:update,:destroy,:new]
  authorize_resource
  def index
    @flavors_for_store = current_user.employee.current_assignment.store.store_flavors.paginate(page: params[:page]).per_page(8)
    
  end

  def show
    
  end

  def new
    @store_flavor = StoreFlavor.new
  end

  def edit
  end

  def create
    @store_flavor = StoreFlavor.new(store_flavor_params)
    
    if @store_flavor.save
      redirect_to store_flavors_path, notice: "Successfully created store_flavor."
    else
      render action: 'new'
    end
  end

  def update
    if @store_flavor.update(store_flavor_params)
      redirect_to home_path, notice: "Successfully updated store_flavor."
    else
      render action: 'edit'
    end
  end

  def destroy
    @store_flavor.destroy
    redirect_to store_flavors_path, notice: "Successfully removed store_flavor from the AMC system."
  end

  private
  def set_store_flavor
    @store_flavor = StoreFlavor.find(params[:id])
  end

  def store_flavor_params
    params.require(:store_flavor).permit(:store_id,:flavor_id, :active)
  end

end