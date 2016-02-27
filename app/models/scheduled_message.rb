class ScheduledMessage < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates_presence_of :body, :group, :scheduled_at
  validate :user_quota_limit

  def user_quota_limit
    unless self.user.quota_limit_check
      errors.add(:scheduled_message, "would exceeded your quota. So we cannot schedule it.")
    end
  end
end
