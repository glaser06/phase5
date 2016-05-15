class ShiftJobsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:edit,:update,:destroy,:new]
  authorize_resource
  def index
    # @upcoming_shifts = ShiftJob.upcoming.chronological.paginate(page: params[:page]).per_page(10)
    # @past_shifts = ShiftJob.past.chronological.paginate(page: params[:page]).per_page(10)  
  end

  def show
    
  end

  def new
    @shift_job = ShiftJob.new
  end

  def edit
  end

  def create
    @shift_job = ShiftJob.new(shift_params)
    
    if @shift_job.save
      redirect_to shift_path(@shift_job), notice: "Successfully created shift_job."
    else
      render action: 'new'
    end
  end

  def update
    if @shift_job.update(shift_params)
      redirect_to shift_path(@shift_job), notice: "Successfully updated shift_job."
    else
      render action: 'edit'
    end
  end

  def destroy
    @shift_job.destroy
    redirect_to shifts_path, notice: "Successfully removed shift_job from the AMC system."
  end

  private
  def set_shift
    @shift_job = ShiftJob.find(params[:id])
  end

  def shift_params
    params.require(:shift_job).permit(:store_id,:job_id, :active)
  end

end