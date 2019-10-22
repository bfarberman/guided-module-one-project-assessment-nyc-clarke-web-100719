require_relative '../config/environment'
require 'tty-prompt'


class CommandLineInterface


def greet
    puts "Greetings from GigGetter! We'll help you get a gig!"
    puts "You're in a touring band, right? Wanna book an out-of-town show? We'll do it for you!"
end


def city_name
   # puts "You're in a touring band, right? Wanna book an out-of-town show?"
    #puts "Throw out a city and we'll talk."
end


def run 
    greet 
    band_called  
    which_city
    show_info
    ending 
end


def band_called  
    prompt = TTY::Prompt.new
    band_name = prompt.ask("What's your band called?")
    band = Band.find_by(name: band_name)
    if band 
        puts "Welcome Back! #{band.name} rocks! "
    else 
        puts "Sorry, that band was not found. We've added it to the database."
        genre = prompt.ask("What is your band's genre?")
        popularity = prompt.ask("How popular is your band? Is your band big or small?")
        Band.create(name: band_name, genre: genre, popularity: popularity)
    end 
end 

def which_city
    prompt = TTY::Prompt.new
    city_array = City.all.map {|city|  city.name}
    chosen_city = prompt.select("Okay, which city would you like to play in?", city_array)
    puts "Sick! We love that place."
    puts  "Here is the recommended venue for that city:"
    found_city = City.find_by(name: chosen_city)
    found_city.venues.each { |venue| puts venue.name}
end 

def show_info
    prompt = TTY::Prompt.new
    result = prompt.collect do
        key(:start_time).ask("At what time would you like to commence jamming?")
        key(:end_time).ask("At what time would you like to end?")
        #show.create(start_time:, end_time)         
    end 
      
end 


def ending
    puts "Okay, confirmed! This is gonna shred! See you at the show!"
end 















end 