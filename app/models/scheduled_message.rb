class ScheduledMessage < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates_presence_of :body, :group, :scheduled_at
  validate :user_quota_limit

  def user_quota_limit
    if self.user.exceeded_quota_limit?
      errors.add(:scheduled_message, "would exceed your quota. So it cannot be sent.")
    end
  end
end
