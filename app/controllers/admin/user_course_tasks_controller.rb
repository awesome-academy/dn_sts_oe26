class Admin::UserCourseTasksController < ApplicationController
  before_action :load_user_course_task, only: [:edit, :update, :destroy]
  def index
   @user_course_tasks = UserCourseTask.select("user_course_tasks.*, users.name as name, tasks.title as title,
                                               subjects.name as subject_name ")
                                      .joins("join users on user_course_tasks.user_id = users.id
                                              join tasks on user_course_tasks.task_id = tasks.id
                                              join subjects on tasks.subject_id = subjects.id")
  end

  def edit

  end

  def update
    if @user_course_task.update_attributes status_params
      flash[:success] = t ".update_success"
      redirect_to admin_user_course_tasks_path
    else
      flash[:danger] = t ".not_success"
      render :edit
    end
  end

  def destroy
    if @user_course_task.destroy
      flash[:success] = t ".delete_success"
      redirect_to admin_user_course_tasks_path
    else
      flash[:danger] = t ".delete_fail"
      redirect_to admin_user_course_tasks_path
    end
  end

  private

  def load_user_course_task
    @user_course_task = UserCourseTask.find_by id: params[:id]
    return if @user_course_task
    flash[:danger] = "Not found"
    redirect_to root_path
  end

  def status_params
    params.require(:user_course_task).permit :status
  end

end
