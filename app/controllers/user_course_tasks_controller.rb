class UserCourseTasksController < ApplicationController
  authorize_resource
  before_action :load_user_course_task, only: [:edit, :update, :destroy]
  
  def create
    @usercoursetaskser = current_user.user_course_tasks.build user_course_task_params
    respond_to do |format|
      if @usercoursetaskser.save
        flash[:success] = t "subjects.show.submit"
        format.html {redirect_to course_path(id: @usercoursetaskser.course_id,
                                             join_date: params[:usercoursetask][:join_date])}
      else
        format.js
      end
    end
  end

  def edit
    @join_date = params[:join_date]
  end

  def update
    respond_to do |format|
      if @user_course_task.update_attributes status_params
        flash[:success] = t "users.show.update_success"
        format.html {redirect_to course_path(id: params[:user_course_task][:course_id],
                                             join_date: params[:user_course_task][:join_date])}
      else
        format.js
      end
    end
  end

  def destroy
    if @user_course_task.destroy
      flash[:success] = t "courses.show.delete_success"
      redirect_to course_path(id: params[:course_id], join_date: params[:join_date])
    else
      flash[:danger] = t "courses.show.not_success"
      redirect_to notfound_path
    end
  end

  private

  def load_user_course_task
    @user_course_task = UserCourseTask.find_by(id: params[:id])
    return if @user_course_task
    flash["danger"] = t "courses.notfound.notfound"
    redirect_to notfound_path
  end

  def user_course_task_params
    params.require(:usercoursetask).permit :course_id, :task_id, :file_excel
  end

  def status_params
    params.require(:user_course_task).permit :status
  end
end
