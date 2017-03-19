class Form::Base
  include Tainbox
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_reader :object, :operation, :prev_attributes, :called_method

  delegate :persisted?, to: :object

  def initialize(object, params = nil)
    @object = object
    @operation = object&.persisted? ? 'update' : 'create'
    @prev_attributes = object&.attributes
    self.attributes = params || @object&.attributes
  end

  def to_model
    object
  end

  def submit(message = nil, &block)
    return unless valid?
    object.assign_attributes(attributes)
    ActiveRecord::Base.with_advisory_lock(message ? message : object.class.to_s) do
      ActiveRecord::Base.transaction do
        object.save!
        block.call if block_given?
        create_logs
        true
      end
    end
  end
  
  private

  def create_logs
    current_user = RequestStore.store[:current_user]
    if current_user.present?
      SystemLog.create!(user_id: current_user.id, data: data_to_store, operation: operation)
    end
  end

  def data_to_store
    case operation
    when 'create'
      data = { klass: object.class.to_s, attributes: object.attributes }
    when 'update'
      data = {
        klass: object.class.to_s,
        prev_attributes: prev_attributes,
        new_attributes: object.attributes,
        attributes_difference: hashes_difference(object.attributes, prev_attributes)
      }
    when 'destroy'
      data = {
        klass: object.class.to_s,
        attributes: object.attributes
      }
    end
  end

  def hashes_difference(first_hash, second_hash)
    diff = first_hash.to_a - second_hash.to_a
    Hash[*diff.flatten]
  end
end
