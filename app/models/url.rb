class Url < ApplicationRecord
  include UniqueKey

  validates :original, presence: true, format: { with: URI.regexp }
end
