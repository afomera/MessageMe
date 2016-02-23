class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :to_phone_number, :body

  after_commit :send_sms_job

  attr_reader :group_id

  private
    def send_sms_job
      SendSmsJob.perform_later self
    end
end
