class User < ApplicationRecord
    has_and_belongs_to_many :recipes
    has_secure_password
    validate :password
    # validates :password_digest, length:{ minimum: 8 }
    # validates :password_digest, presence: true
    # validates :password_digest, uniqueness: { case_sensitive: true }
    # validates :password_digest, format: { with: /\A[a-zA-Z]+\z/, message: "must have a combination of letters and numbers." }
    validates :email, presence: true
    validates :email, format: { with: /(.+)@(.+)/, message: "invalid"  }, uniqueness: { case_sensitive: false },length: { minimum: 4, maximum: 254 }       

    def password
        if :password_digest.blank?
            errors.add(:password, "cannot be blank")
        # elsif :password_digest.length < 8
        #     errors.add(:password, "must be at least 8 characters")
        # elsif :password_digest.!match(/\A[a-zA-Z]+\z/)
        #     errors.add(:password, "must contain letters")
        # elsif :password_digest.!match(/[0-9]/)
        #     errors.add(:password, "must contain numbers")
        end
    end

    def self.favorited_recipes
    end

    def self.created_recipes
    end

    def self.count_favorited
    end
end


    # validates :password_digest_digest, length:{ minimum: 8 }
    # validates :password_digest_digest, presence: true
    # validates :password_digest_digest, uniqueness: { case_sensitive: true }
    # validates :password_digest_digest, format: { with: /\A[a-zA-Z]+\z/, message: "must have a combination of letters and numbers." }

