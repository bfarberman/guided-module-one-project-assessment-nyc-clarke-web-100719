class Band < ActiveRecord::Base
    has_many :shows
    has_many :venues, through: :shows 
end 
