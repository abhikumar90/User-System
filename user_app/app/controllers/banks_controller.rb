class BanksController < ApplicationController
before_action :set_pinboard, only: [:show, :edit, :update, :destroy]


  def index
    @pin_properties = current_user.email
  end

  def show
    #@comments = @idea.comments.all
    #@comment = @idea.comments.build
  end

  def new
    @pin_properties = Bank.new
  end

  def edit
    if @pin_properties.user != current_user
      respond_to do |format|
        format.html { redirect_to pinboard_path, alert: 'You are not authorized to edit this pinboard.' }
        format.json { head :no_content }
      end
      return false
    end
  end

  def create
    @pin_property = Bank.new(pinboard_params)
     @pin_property.user = current_user

    respond_to do |format|
      if @pin_property.save
        format.html { 
          redirect_to pinboards_path, notice: 'PinProperty was successfully created.' 
        }
        format.json { render :show, status: :created, location: @pin_property }
      else
        format.html { render :new }
        format.json { render json: @pin_property.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_all_user_details
      @users = User.all - [User.find_by_email("admin@bitlasoft.com"),User.find_by_email(current_user.email)]
      render :template => "/pinboards/users_list" 
  end

def view_my_profile
  
end

def block_users
   @users = User.all - [User.find_by_email(current_user.email)]
   render :template => "/pinboards/block_users" 
end


def assign_picture_to_user
 if params[:pinboard]
     @pin_property = Bank.new(pinboard_params)
     @pin_property.user_id = params[:id]
    respond_to do |format|
      if @pin_property.save
        format.html { 
          redirect_to pinboards_path, notice: 'Picture is successfully added in your friend pinboard.' 
        }
      else
        format.html {  render :template => "/friendships/assign_picture_to_user"}
      end
    end
  else
    render :template => "/friendships/assign_picture_to_user"
  end
end

def change_user_status
  @user = User.find(params[:id])
  @user.status = false
  @user.save
  redirect_to "/block_users" ,notice: "#{@user.email} has been blocked."
end

  def update
    respond_to do |format|
      if @pin_property.update(idea_params)
        format.html { redirect_to pinboards_path, notice: 'PinProperty was successfully updated.' }
        format.json { render :show, status: :ok, location: @pin_property }
      else
        format.html { render :edit }
        format.json { render json: @pin_property.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if @pin_property.user != current_user
      respond_to do |format|
        format.html { redirect_to pinboard_path, alert: 'You are not authorized to destroy this pinboard.' }
        format.json { head :no_content }
      end
      return false
    end
    @pin_property.destroy
    respond_to do |format|
      format.html { redirect_to pinboards_url, notice: 'PinProperty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   
     def set_pinboard
      @pin_property = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pinboard_params
      params.require(:pinboard).permit(:name, :description, :picture)
    end
end
