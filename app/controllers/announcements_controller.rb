class AnnouncementsController < ApplicationController

  def index
    @announcements = Announcement.all 
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)

    if @announcement.save!
      redirect_to announcement_path(@announcement), notice: 'New Announcement Added'
    else
      render :new
    end
  end

  def edit
    @announcement = Announcement.find(params[:id]) 
  end

  def update
    @announcement = Announcement.find(params[:id]) 

    if @announcement.update(announcement_params)
      redirect_to announcement_path(@announcement), notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :description)
  end

end
