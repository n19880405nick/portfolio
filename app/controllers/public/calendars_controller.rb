class Public::CalendarsController < ApplicationController
  def create
    @calendar = current_user.calendars.find_or_initialize_by(created_at: Time.now.all_day)
    if @calendar.new_record?
      @calendar = Calendar.new(calendar_params)
      @calendar.user_id = current_user.id
      @calendar.day = Time.now.day
      @calendar.month = Time.now.month
      @calendar.save
    else
      @calendar.update(calendar_params)
    end
    redirect_to my_page_path
  end

  private

  def calendar_params
    params.require(:calendar).permit(:sleeping_time, :day, :month)
  end
end
