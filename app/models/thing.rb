class Thing < ApplicationRecord
  belongs_to :parent, class_name: "Thing", optional: true
  has_many :children, class_name: "Thing", foreign_key: :parent_id
end
