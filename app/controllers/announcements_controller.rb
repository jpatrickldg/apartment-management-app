class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_announcement, only: [ :show, :edit, :update, :archive, :republish ]

  def index
    @announcements = Announcement.all 
    @published = Announcement.where(status: 'published')
    @draft = Announcement.where(status: 'draft')
    @archived = Announcement.where(status: 'archived')
  end

  def show
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)

    if @announcement.save
      check_if_publishing
      check_if_saved_as_draft
      redirect_to announcement_path(@announcement), notice: 'New Announcement Added'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @announcement.update(announcement_params)
      check_if_publishing
      check_if_saved_as_draft
      redirect_to announcement_path(@announcement), notice: 'Updated Successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    @announcement.archived!
    redirect_to announcement_path(@announcement), notice: 'Announcement Archived'
  end

  def republish
    @announcement.published!
    @announcement.set_published_by(current_user.email)
    redirect_to announcement_path(@announcement), notice: 'Announcement Published'
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end
  
  def announcement_params
    params.require(:announcement).permit(:title, :description, :status)
  end

  def check_if_publishing
    if params[:commit] == "Publish"
      @announcement.published!
      @announcement.set_published_by(current_user.email)
    end
  end

  def check_if_saved_as_draft
    if params[:commit] == "Save as Draft"
      @announcement.draft!
    end
  end
  
end
