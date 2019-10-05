class Make < ApplicationRecord
    has_many :cars, dependent: :nullify # don't destroy cars when their make is destroyed
    validates :name, presence: true, uniqueness: true # validate make
    validates :country, presence: true # validate country
end
