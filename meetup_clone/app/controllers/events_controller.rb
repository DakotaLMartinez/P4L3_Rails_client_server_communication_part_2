class EventsController < ApplicationController
  def index
    render json: Event.all
  end

  def show
    event = Event.find(params[:id])
    render json: event
  end

  def create
    event = current_user.created_events.build(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.permit(:title, :description, :location, :start_time, :end_time, :group_id)
  end
end
