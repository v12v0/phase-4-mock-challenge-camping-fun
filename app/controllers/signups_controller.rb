class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :signup_not_created

    def create 
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    end



    private

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def signup_not_created(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
