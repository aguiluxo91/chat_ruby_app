class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :logged_in_redirect, only: [:new, :create]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @user = User.new
    end

    def edit
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to MessageMe #{@user.username}"
            redirect_to root_path
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to user_path
        else
            puts @user.errors.full_messages
            render 'edit', status: :unprocessable_entity
        end
    end

    def show
    end

    def destroy
        @user.destroy
        flash[:error] = "User was removed"
        redirect_to users_path
    end




    private
        def user_params
            params.require(:user).permit(:username, :email, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end

        def logged_in_redirect
            if logged_in?
                flash[:error] = "You are already logged in"
                redirect_to root_path
            end
        end

        def require_same_user
            if current_user != @user and !current_user.admin?
                flash[:error] = "You can only edit your own account"
                redirect_to root_path
            end
        end

        def require_admin
            if logged_in? and !current_user.admin?
                flash[:error] = "Only admin users can perform that action"
                redirect_to root_path
            end
        end
end