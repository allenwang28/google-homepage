require 'jumpstart_auth'

class MicroBlogger
  attr_accessor :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.length > 140   
      puts "Exceeds 140 characters. Not tweeted"
    else
      @client.update(message)
      puts "Tweeting (#{message})..."
    end
  end

  def my_followers
    @client.followers.collect { |follower| @client.user(follower).screen_name }
  end

  def dm(target, message)
    puts "Trying to send \"#{message}\" to #{target}"
    followers = my_followers
    if followers.include?(target)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "User is not following you. Not tweeted"
    end
  end

  def everyones_last_tweets
    friends = @client.friends
    friends.each do |friend|
      message = friend.status.created_at
      puts "#{friend.screen_name} said..."
      puts message
      puts ""
    end
  end

  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'elt' then everyones_last_tweets
        else
          puts "Sorry, I don't know how to #{command}"
      end

    end
  end
end

blogger = MicroBlogger.new
blogger.run
