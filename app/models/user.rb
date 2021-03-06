class User < ApplicationRecord
  has_one :active_user, dependent: :destroy, autosave: true
  has_one :cancelled_user, dependent: :destroy
  has_one :developer

  delegate :name, :email, :accounts, :avatar_url, to: :user_with_status
  delegate :team, to: :team_member, allow_nil: true

  class << self
    def activate(name:, email:, avatar_url:, account:)
      active_user = ActiveUser.new_with_account(name: name, email: email, avatar_url: avatar_url, account: account)
      new { _1.active_user = active_user }
    end

    def find_active_by_account(account)
      joins(active_user: :accounts).find_by(accounts: { provider: account.provider, uid: account.uid })
    end
  end

  def cancel
    self.tap do |user|
      user.active_user.mark_for_destruction
      user.build_cancelled_user
    end
  end

  def user_with_status
    @__user_with_status ||= [active_user, cancelled_user].compact.first
  end

  def developer?
    reload
    developer.present?
  end

  def active?
    user_with_status.is_a?(ActiveUser)
  end
end
