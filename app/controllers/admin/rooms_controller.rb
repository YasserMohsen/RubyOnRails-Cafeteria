class Admin::RoomsController < Admin::AdminController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  semantic_breadcrumb "Rooms", :admin_rooms_path

  def index
    @rooms = Room.all
  end

  def new
    semantic_breadcrumb "Create", new_admin_room_path
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to admin_rooms_path, notice: 'Room was successfully created.'
    else
      semantic_breadcrumb "Create", new_admin_room_path
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to admin_rooms_path, notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to admin_rooms_path, alert: 'Room was successfully destroyed.'
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end
end
