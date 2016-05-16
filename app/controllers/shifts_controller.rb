class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:edit,:update,:destroy,:new]
  authorize_resource
  def index
    @upcoming_shifts = Shift.upcoming.chronological.by_store.paginate(page: params[:page]).per_page(10)
    @past_shifts = Shift.past.chronological.paginate(page: params[:page]).per_page(10)  
  end

  def show
    
  end

  def new
    @shift = Shift.new
  end

  def edit
  end

  def create
    @shift = Shift.new(shift_params)
    
    if @shift.save
      redirect_to shift_path(@shift), notice: "Successfully created shift."
    else
      render action: 'new'
    end
  end

  def update
    if @shift.update(shift_params)
      redirect_to shift_path(@shift), notice: "Successfully updated shift."
    else
      render action: 'edit'
    end
  end

  def destroy
    @shift.destroy
    redirect_to shifts_path, notice: "Successfully removed shift from the AMC system."
  end

  private
  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:date, :start_time, :end_time, :notes, :assignment_id, :phone, :active)
  end

end