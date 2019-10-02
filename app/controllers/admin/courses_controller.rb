class Admin::CoursesController < ApplicationController
  before_action :load_course, only: [:edit, :destroy, :update, :show]

  def index
    @courses = Course.all
  end

  def show
    @course_subjects = @course.course_subjects.select_subjects.with_subjects.sort_by_order
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t ".created_success"
      redirect_to admin_courses_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t ".update_success"
      redirect_to admin_courses_path
    else
      render :edit
    end
  end

  def destroy
    key = @course.destroy ? ".delete_success" : ".delete_fail"
    flash[:info] = t(key, name: @course.name)
    redirect_to admin_courses_path
  end

  private

  def course_params
    params.require(:course).permit :name, :content, :start_date, :status, :location
  end

  def load_course
    @course = Course.find_by(id: params[:id])
    return if @course
    flash["danger"] = t "courses.notfound.notfound"
    redirect_to notfound_path
  end
end
