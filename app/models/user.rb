require "rolify"

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :invitable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  rolify

  def self.policy_class
    UserPolicy
  end

  # Use ActiveJob to deliver Devise emails
  # https://github.com/plataformatec/devise#activejob-integration
  def send_devise_notification(notification, *args)
    if Rails.application.config.active_job.queue_adapter == :inline
      super
    else
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end


end
