class OpportunitySerializer < ActiveModel::Serializer
  attributes :id, :actable_type, :actable_id
  has_one :actable
end
