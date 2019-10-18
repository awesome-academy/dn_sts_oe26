class TasksController < ApplicationController
  authorize_resource
  before_action :load_task, only: [:edit, :update, :destroy]

  def create
    @task = Task.new full_params
    respond_to do |format|
      if @task.save
        flash[:success] = t ".create_success"
        format.html{redirect_to course_subject_path(course_id: params[:task][:course_id],
                                                    id: params[:task][:subject_id])}
      else
        format.js
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @task.update_attributes task_params
        flash[:success] =  t ".update_success"
        format.html {redirect_to course_subject_path(course_id: params[:task][:course_id],
                                                     id: params[:task][:subject_id])}
      else
        format.js
      end
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = t ".delete_success"
      redirect_to course_subject_path(course_id: params[:course_id], id: params[:subject_id])
    else
      flash[:danger] = t ".delete_fail"
      redirect_to notfound_path
    end
  end

  private

  def load_task
    @task = Task.find_by id: params[:id]
    return if @task
    flash["danger"] = t ".courses.notfound.notfound"
    redirect_to notfound_path
  end

  def task_params
    params.require(:task).permit :title, :content
  end

  def full_params
    params.require(:task).permit :title, :content, :subject_id
  end
end
