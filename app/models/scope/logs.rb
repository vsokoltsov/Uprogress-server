# frozen_string_literal: true
class Scope::Logs
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def recent_actions
    logs = sorted_logs.group_by do |item|
      item.created_at.to_date
    end

    Hash[*logs.flatten]
  end

  private

  def sorted_logs
    @user.system_logs
         .order(created_at: :desc)
         .limit(5)
         .sort do |a, b|
      b.created_at <=> a.created_at
    end
  end
end
