class EventsController < ApplicationController

  def index
    @events = current_team.events
  end
end
