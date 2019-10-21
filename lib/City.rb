class City < ActiveRecord::Base
    has_many :venues
    has_many :shows, through: :venues 
end 