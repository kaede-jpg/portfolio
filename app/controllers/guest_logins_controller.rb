class GuestLoginsController < ApplicationController
  skip_before_action :require_login, only: %i[create]
  def create
    guest_user = User.create(
      name: 'ゲスト',
      email: "#{SecureRandom.alphanumeric(10)}@email.com",
      password: 'password',
      password_confirmation: 'password',
      role: 'monitored',
      guest: true,
      agreement: true
    )
    guest_user.activate!
    auto_login(guest_user)
    record = guest_user.records.build
    record.meal_image.attach(
      io: Rails.root.join('app/assets/images/sample_meal.jpg').open,
      filename: 'sample_meal.jpg',
      content_type: 'image/jpg'
    )
    record.save!
    MealAdviseJob.perform_later(record)
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
end
