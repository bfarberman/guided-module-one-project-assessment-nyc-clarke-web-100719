require_relative '../config/environment'
require 'tty-prompt'


class CommandLineInterface
    PROMPT = TTY::Prompt.new

    def run 
        greet
        sign_up_or_login
        main_menu
        # band = band_called  
        # venue_to_booked = which_city
        # show_info(venue_to_booked,band)
        # anything_else(band)
    end

    def main_menu
        puts `clear`
        PROMPT.select("What would you like to do?") do |menu|
             menu.choice "Book a Venue", -> { choose_city }
             menu.choice "My Shows",     -> { list_my_shows }
             menu.choice "Cancel a Show", -> { cancel_a_show }
             menu.choice "Update a Show"
             menu.choice "Change band name", -> { change_band_name }
             menu.choice "Exit"
         end
     end

    def sign_up_or_login  
        band_name = PROMPT.ask("What's your band called?")
        @band = Band.find_by(name: band_name)
        if @band 
            puts "Welcome Back! #{@band.name} rocks! "
        else 
            puts "Sorry, that band was not found. We've added it to the database!"
            genre = PROMPT.ask("What is your band's genre?")
            popularity = PROMPT.ask("How popular is your band? Is your band big or small?")
            @band = Band.create(name: band_name, genre: genre, popularity: popularity)
        end
    end 

def greet
    puts `clear`
    puts "Greetings from GigGetter! We'll help you get a gig!"
    puts "You're in a touring band, right? Wanna book an out-of-town show? We'll do it for you!"
end


def city_name
   # puts "You're in a touring band, right? Wanna book an out-of-town show?"
    #puts "Throw out a city and we'll talk."
end


def choose_city
    # city_array = City.all.map {|city|  city.name}
    PROMPT.select("Okay, which city would you like to play in?") do |menu|
        City.all.each do |city|
            menu.choice city.name, -> do
                venue = choose_venue_for_city(city)
                date_of_set = get_date_from_user

                create_show(date_of_set, venue)
                main_menu
            end
        end
        menu.choice "<< Back", -> { main_menu }
    end

    # puts "Sick! We love that place."
    # puts  "Here is the recommended venue for that city:"
    # found_city = City.find_by(name: chosen_city)
    # found_city.venues.each { |venue| puts venue.name}
    # found_city.venues.first
end 






def create_show(date_of_set, venue)
    Show.create(
        band_id: @band.id, 
        venue_id: venue.id, 
        start_time: date_of_set[:start_time], 
        end_time: date_of_set[:end_time]
    )
end 

def choose_venue_for_city(city)
    # eventually, this will be a menu where user can pick venue.
    # for now, we will just pick the first venue for that city.
    chosen_venue = city.venues.first
    puts  "Here is the recommended venue for that city: #{chosen_venue.name}"
    chosen_venue
end

def get_date_from_user
    puts "On which date and at what time would you like to commence jamming? Use this format: YYYY-MM-DD HH:MM:SS UTC"
    start_t = gets.chomp
    puts "At what time would you like to finish your encore? Use this format: YYYY-MM-DD HH:MM:SS UTC"
    end_t = gets.chomp
    {
        start_time: start_t,
        end_time: end_t
    }
end

def list_my_shows
    PROMPT.select("Select a show to see its details") do |menu|
        @band.shows.each do |show|
            menu.choice "#{show.venue.name}, #{show.start_time}", -> do
                display_show_info(show)
                prompt_return_to_main_menu
            end
        end
        menu.choice "<< Back", -> { main_menu }
    end
end

def display_show_info(show)
    puts "Here is the detail for your gig at #{show.venue.name}"
    puts "====================================================="
    puts "Start time: #{show.start_time}"
    puts "End time:   #{show.end_time || "TBA" }"
end

def prompt_return_to_main_menu
    PROMPT.select("return to main menu") do |menu|
        menu.choice "Return to Main Menu", -> { main_menu }
    end
end


def show_info(venue,band)
    # result = PROMPT.collect do
    #     key(:start_t).ask("At what time would you like to commence jamming?")
    #     key(:end_t).ask("At what time would you like to finish your encore?")
                
    # end 
    puts "On which date and at what time would you like to commence jamming? Use this format: YYYY-MM-DD HH:MM:SS UTC"
    start_t = gets.chomp
    puts "At what time would you like to finish your encore? Use this format: YYYY-MM-DD HH:MM:SS UTC"
    end_t = gets.chomp

    Show.create(band_id: band.id, venue_id: venue.id, start_time: start_t, end_time: end_t) 
end 


def change_band_name
    ans = PROMPT.ask("New band name:")
        Band.update(@band.id, name: ans)
        main_menu
    end

def cancel_a_show
    PROMPT.select("Select the show you'd like to cancel") do |menu|
        @band.shows.each do |show|
            menu.choice "#{show.venue.name}, #{show.start_time}", -> do
                Show.destroy(show.id)
                prompt_return_to_main_menu
            end
        end
        menu.choice "<< Back", -> { main_menu }
    end
end






def anything_else(band)
    ans = PROMPT.select("Okay, confirmed! Would you like to do anything else with the details of your show?", ["View", "Alter Band Name", "Alter Start Time", "Alter End Time", "Delete the Band You Just Created", "Delete the Show You Just Created", "Nope, I'm good!"])
    if ans == "View" 
        db_band = Band.find(band.id)
        latest_show = db_band.shows.last
        puts latest_show.band.name
        puts latest_show.venue.name
        puts latest_show.start_time
        puts latest_show.end_time 
    elsif ans == "Alter Band Name"
        ans = PROMPT.ask("New band name:")
        Band.update(band.id, name: ans  )
    elsif ans == "Alter Start Time"
        ans = PROMPT.ask("Change start time using format YYYY-MM-DD HH:MM:SS UTC:")
        Show.update(Show.last.id, start_time: ans) 
    elsif ans == "Alter End Time"
        ans = PROMPT.ask("Change end time using format YYYY-MM-DD HH:MM:SS UTC:")
        Show.update(Show.last.id, end_time: ans) 
    elsif ans == "Delete the Band You Just Created"
        ans = PROMPT.ask("Type Y to delete the band you just created:")
        Band.destroy(Band.last.id)
    elsif ans == "Delete the Show You Just Created"
        ans = PROMPT.ask("Type Y to delete the show you just created:")
        Show.destroy(Show.last.id)
    elsif ans == "Nope, I'm good!"
        puts "Okay, cool. See you at the show! Gonna be killer!"
        end
    end 
end 