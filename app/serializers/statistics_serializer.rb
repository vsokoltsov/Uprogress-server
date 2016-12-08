# frozen_string_literal: true
class StatisticsSerializer < ActiveModel::Serializer
  attr_accessor :query_scope
  attributes :directions, :steps, :directions_steps

  delegate :directions, :steps, :directions_steps, to: :query_scope

  def query_scope
    @query_scope ||= Scope::Statistics.new(object)
  end

  def json_key
    'statistics'
  end
end
