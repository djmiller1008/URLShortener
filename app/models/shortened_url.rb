class ShortenedUrl < ApplicationRecord
    validates :short_url, :long_url, :user_id, presence: true
    validates :short_url, uniqueness: true

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User


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