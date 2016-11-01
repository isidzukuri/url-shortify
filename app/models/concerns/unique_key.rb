module UniqueKey
  def self.included(base)
    base.instance_eval do
      validates :key, presence: true, format: { with: /[A-Za-z2-9]/ }
      validates_uniqueness_of :key
      before_validation :generate_key, on: :create
    end
  end

  private

  def generate_key
    key_length = 5
    attempt = 0
    self.key = loop do
      if attempt == 5
        attempt = 0
        key_length += 1
      else
        attempt += 1
      end
      key = random_key(key_length)
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
