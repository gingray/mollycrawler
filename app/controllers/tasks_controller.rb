class TasksController < ApplicationController

  def create
    ivar = permited_params[:processor].constantize.new
    hash = { data: permited_params[:data], tid: permited_params[:tid] }
    ivar.process hash
    redirect_to root_path
  end

  private 

  def permited_params
    params.require(:task).permit(:tid, :processor, :data)
  end
end
