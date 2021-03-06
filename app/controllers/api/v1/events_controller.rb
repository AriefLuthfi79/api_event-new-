class Api::V1::EventsController < ApplicationController
  # Only specific action must authenticated
  skip_before_action :authenticate_user, only: [:index, :show]
  before_action :load_resource

  # Shows all events in home
  def index
    events = Event.all.evaluate_event
    render json: events, each_serializer: EventSerializer
  end

  # Show specific event if clicked
  def show
    render json: @event
  end

  # User can create new event
  def create
    @event.user_id = current_user.id
    if @event.save && @event.has_valid_date?
      @event.create_ticket(ticket_params)
      render json: { status: { created: "OK" } }
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    render json: { status: :deleted }
  end

  private

  # Get parameter to permit
  def new_event
    Event.new(event_params)
  end

  # Load resource before action
  def load_resource
    case params[:action].to_sym
    when :create
      @event = new_event
    when :show, :destroy
      @event = Event.find(params[:id])
    end
  end

  # Get params event
  def event_params
    params.permit(:name,
                  :capacity,
                  :description,
                  :date,
                  :time_event,
                  :image,
                  :time,
                  :place,
                  :quantity,
                  :latitude,
                  :longitude)
  end

  # Get params ticket
  def ticket_params
    params.permit(:ticket_name,
                  :ticket_description)
  end
end
