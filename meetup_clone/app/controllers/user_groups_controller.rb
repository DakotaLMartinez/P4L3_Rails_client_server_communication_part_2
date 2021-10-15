class UserGroupsController < ApplicationController
  def create
    user_group = current_user.user_groups.build(user_group_params)
    if user_group.save
      render json: user_group, status: :created
    else
      render json: user_group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    UserGroup.find(params[:id]).destroy
  end

  private

  def user_group_params
    params.permit(:group_id)
  end
end
