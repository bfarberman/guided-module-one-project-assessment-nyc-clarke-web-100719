require_relative '../config/environment'
require 'tty-prompt'


class CommandLineInterface


def greet
    puts "Greetings from GigGetter! We'll help you get a gig!"
    puts "You're in a touring band, right? Wanna book an out-of-town show? Talk to us!"
end


def city_name
   # puts "You're in a touring band, right? Wanna book an out-of-town show?"
    #puts "Throw out a city and we'll talk."
end


def run 
    greet 
    band_called  
    which_city
end


def band_called  
    prompt = TTY::Prompt.new
    prompt.ask("What's your band called?")
        puts "Cool! We bet you guys rock!"
end 

def which_city
    prompt = TTY::Prompt.new
    city_array = City.all.map {|city|  city.name}
    chosen_city = prompt.select("Which city would you like to play in?", city_array)
    puts "Sick! We love that place."
    puts  "Here are the recommended venues for that city. Take your pick!"
    found_city = City.find_by(name: chosen_city)
    found_city.venues.each { |venue| puts venue.name}
end 

def recommended_venue

end 


















end 