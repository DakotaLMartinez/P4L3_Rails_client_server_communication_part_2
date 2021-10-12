class GroupsController < ApplicationController
  def index
    render json: Group.all
  end

  def show
    group = Group.find(params[:id])
    render json: group, include: [:members]
  end
end
