class InstructorsController < ApplicationController
    before_action :set_instructor, only: [:show, :update, :destroy]
  
    def index
      instructors = Instructor.all
      render json: instructors, status: :ok
    end
  
    def show
      render json: @instructor, status: :ok
    end
  
    def create
      instructor = Instructor.new(instructor_params)
      if instructor.save
        render json: instructor, status: :created
      else
        render json: { errors: instructor.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @instructor.update(instructor_params)
        render json: @instructor, status: :ok
      else
        render json: { errors: @instructor.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @instructor.destroy
      render json: { message: 'Instructor deleted' }, status: :ok
    end
  
    private
  
    def set_instructor
      @instructor = Instructor.find_by(id: params[:id])
      unless @instructor
        render json: { error: 'Instructor not found' }, status: :not_found
      end
    end
  
    def instructor_params
      params.permit(:name)
    end
end  