class Venue < ActiveRecord::Base
    has_many :shows
    has_many :bands, through: :shows 
    belongs_to :city
end 