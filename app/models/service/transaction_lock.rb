# frozen_string_literal: true
class Service::TransactionLock
  def self.run_with_message(message, &block)
    ActiveRecord::Base.with_advisory_lock(message) do
      ActiveRecord::Base.transaction do
        block.call if block_given?
      end
    end
  end
end
