class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
     if current_user.role == 'admin'
    users = User.all
    render json: users, status: :ok
    else
    render json: { errors: "Forbidden" },
            status: :forbidden
  end
  end

  # GET /users/{username}
  def show
    render json: User.find_by_username(params[:_username]), status: :ok
  end

  # POST /users
  def create
   
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def find_user
    user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :avatar, :name, :username, :email, :password, :password_confirmation, :role
    )
  end
end