class User < ApplicationRecord
  has_many :things, foreign_key: :created_by_id
end
