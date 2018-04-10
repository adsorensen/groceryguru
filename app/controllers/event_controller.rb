class EventController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @events = Event.where(user_id: session['user_id'])
    render json: @events and return false 
  end
  
  def save
    @event = Event.new(event_params)
    @event.user_id = session['user_id']
    @event.save
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  def update
    @event = Event.find_by(event_id: params[:event_id], user_id: session['user_id'])
    @event.update(event_params)
  end

  def destroy
    @event = Event.find_by(event_id: params[:event_id], user_id: session['user_id'])
    @event.destroy
  end

  private
    def set_event
      @user_id = session['user_id']
    end

    def event_params
      params.permit(:user_id, :event_id, :title, :start_time, :end_time, :allday)
    end
end