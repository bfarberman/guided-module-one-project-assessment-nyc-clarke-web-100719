require_relative '../config/environment'
require 'tty-prompt'


class CommandLineInterface


def greet
    puts `clear`
    puts "Greetings from GigGetter! We'll help you get a gig!"
    puts "You're in a touring band, right? Wanna book an out-of-town show? We'll do it for you!"
end


def city_name
   # puts "You're in a touring band, right? Wanna book an out-of-town show?"
    #puts "Throw out a city and we'll talk."
end


def run 
    greet 
    band = band_called  
    venue_to_booked = which_city
    show_info(venue_to_booked,band)
    anything_else(band)
end


def band_called  
    prompt = TTY::Prompt.new
    band_name = prompt.ask("What's your band called?")
    band = Band.find_by(name: band_name)
    if band 
        puts "Welcome Back! #{band.name} rocks! "
    else 
        puts "Sorry, that band was not found. We've added it to the database!"
        genre = prompt.ask("What is your band's genre?")
        popularity = prompt.ask("How popular is your band? Is your band big or small?")
        band = Band.create(name: band_name, genre: genre, popularity: popularity)
    end 
    band
end 


def which_city
    prompt = TTY::Prompt.new
    city_array = City.all.map {|city|  city.name}
    chosen_city = prompt.select("Okay, which city would you like to play in?", city_array)
    puts "Sick! We love that place."
    puts  "Here is the recommended venue for that city:"
    found_city = City.find_by(name: chosen_city)
    found_city.venues.each { |venue| puts venue.name}
    found_city.venues.first
end 


def show_info(venue,band)
    prompt = TTY::Prompt.new
    # result = prompt.collect do
    #     key(:start_t).ask("At what time would you like to commence jamming?")
    #     key(:end_t).ask("At what time would you like to finish your encore?")
                
    # end 
    puts "On which date and at what time would you like to commence jamming? Use this format: YYYY-MM-DD HH:MM:SS UTC"
    start_t = gets.chomp
    puts "At what time would you like to finish your encore? Use this format: YYYY-MM-DD HH:MM:SS UTC"
    end_t = gets.chomp

        Show.create(band_id: band.id, venue_id: venue.id, start_time: start_t, end_time: end_t) 
end 


def anything_else(band)
    prompt = TTY::Prompt.new
    ans = prompt.select("Okay, confirmed! Would you like to do anything else with the details of your show?", ["View", "Alter Band Name", "Alter Start Time", "Alter End Time", "Delete the Band You Just Created", "Delete the Show You Just Created", "Nope, I'm good!"])
    if ans == "View" 
        db_band = Band.find(band.id)
        latest_show = db_band.shows.last
        puts latest_show.band.name
        puts latest_show.venue.name
        puts latest_show.start_time
        puts latest_show.end_time 
    elsif ans == "Alter Band Name"
        ans = prompt.ask("New band name:")
        Band.update(band.id, name: ans  )
    elsif ans == "Alter Start Time"
        ans = prompt.ask("Change start time using format YYYY-MM-DD HH:MM:SS UTC:")
        Show.update(Show.last.id, start_time: ans) 
    elsif ans == "Alter End Time"
        ans = prompt.ask("Change end time using format YYYY-MM-DD HH:MM:SS UTC:")
        Show.update(Show.last.id, end_time: ans) 
    elsif ans == "Delete the Band You Just Created"
        ans = prompt.ask("Type Y to delete the band you just created:")
        Band.destroy(Band.last.id)
    elsif ans == "Delete the Show You Just Created"
        ans = prompt.ask("Type Y to delete the show you just created:")
        Show.destroy(Show.last.id)
    elsif ans == "Nope, I'm good!"
        puts "Okay, cool. See you at the show! Gonna be killer!"
        end
    end 
end 