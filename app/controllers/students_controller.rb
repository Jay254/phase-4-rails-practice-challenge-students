class StudentsController < ApplicationController
    before_action :set_student, only: [:show, :update, :destroy]
  
    def index
      students = Student.all
      render json: students, status: :ok
    end
  
    def show
      render json: @student, status: :ok
    end
  
    def create
      student = Student.new(student_params)
      if student.save
        render json: student, status: :created
      else
        render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @student.update(student_params)
        render json: @student, status: :ok
      else
        render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @student.destroy
      render json: { message: 'Student deleted' }, status: :ok
    end
  
    private
  
    def set_student
      @student = Student.find_by(id: params[:id])
      unless @student
        render json: { error: 'Student not found' }, status: :not_found
      end
    end
  
    def student_params
      params.require(:student).permit(:name, :major, :age, :instructor_id)
    end
end  