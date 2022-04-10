class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found 
    rescue_from ActiveRecord::RecordInvalid, with: :camper_not_created

    def index 
        render json: Camper.all
    end

    def show 
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private 
    def camper_not_found 
        render json: { error: "Camper not found" }, status: :not_found
    end

    def camper_params
        params.permit( :name , :age)
    end

    def camper_not_created(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
