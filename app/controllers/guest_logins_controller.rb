class GuestLoginsController < ApplicationController
  skip_before_action :require_login, only: %i[create]
  def create
    create_guest_user
    auto_login(@guest_user)
    create_sample_record(@guest_user)
    redirect_to records_path, notice: 'ゲストとしてログインしました'
  end

  def change_role
    if current_user.monitor?
      current_user.monitored!
    else
      current_user.monitor!
    end
    redirect_to records_path
  end

  private

  def create_guest_user
    @guest_user = User.create(
      name: 'ゲスト',
      email: "#{SecureRandom.alphanumeric(10)}@email.com",
      password: 'password',
      password_confirmation: 'password',
      role: 'monitored',
      guest: true,
      agreement: true
    )
   @guest_user.activate!
  end
  
  def create_sample_record(user)
    record = user.records.build
    record.meal_image.attach(
      io: Rails.root.join('app/assets/images/sample_meal.webp').open,
      filename: 'sample_meal.webp',
      content_type: 'image/webp'
    )
    record.save!
    MealAdviseJob.perform_later(record)
  end
end
