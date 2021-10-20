class ShortenedUrl < ApplicationRecord
    validates :short_url, :long_url, :user_id, presence: true
    validates :short_url, uniqueness: true

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    has_many :visits,
        primary_key: :id,
        foreign_key: :short_url_id,
        class_name: :Visit,
        dependent: :destroy

    has_many :visitors,
        -> {distinct},
        through: :visits,
        source: :visitor

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.count
    end

    def num_recent_uniques
        visits
          .select('user_id')
          .where('created_at > ?', 10.minutes.ago)
          .distinct
          .count
    end

    def self.user_and_long_to_short(user, long_url)
        ShortenedUrl.create!(
            user_id: user.id,
            long_url: long_url,
            short_url: ShortenedUrl.random_code
        )
    end

    def self.random_code
       loop do
           random_code = SecureRandom.urlsafe_base64(16)
           return random_code unless self.exists?(short_url: random_code)
       end
    end



end