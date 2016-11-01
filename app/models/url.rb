class Url < ApplicationRecord
  validates :original, presence: true, format: { with: URI.regexp }
  validates :key, presence: true, length: { maximum: 5 }, format: { with: /[A-Za-z2-9]/ }
  validates_uniqueness_of :key

  before_validation :generate_key, on: :create

  private

  def generate_key
    self.key = loop do
      key = random_key
      break key unless self.class.exists?(key: key)
    end
  end

  def random_key(key_length = 5)
    avoid = %w(0 1 i I l L o O)
    uppercase = ('A'..'Z').to_a
    lowercase = ('a'..'z').to_a
    digits    = ('2'..'9').to_a
    pool = digits + lowercase + uppercase - avoid
    pool.sample(key_length).join
  end
end
