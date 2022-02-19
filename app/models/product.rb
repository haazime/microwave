class Product < ApplicationRecord
  attribute :name, :name
  attribute :vision, :long_sentence

  has_one :backlog, class_name: 'ProductBacklog'

  before_create do
    self.build_backlog
  end
end
