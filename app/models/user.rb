class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, :uniqueness => {:case_sensitive => true}
    validates :password, presence: true
end