# Free Points kingdomLikes.com
# by unforgiv3n - (memolob@gmail.com)

require 'rubygems'
require 'selenium-webdriver'
require 'mechanize'
require 'nokogiri'
require 'date'
require 'active_support'

class LinkCrawler
	def initialize
		@driver = nil
	end
	
	def start
		@driver = Selenium::WebDriver.for :chrome
	end
	
	def webdriver
		@driver ||= start
	end

	def navigate_index_page
		@driver.navigate.to "http://kingdomlikes.com"
		puts "Navegando a kingdomlikes"
	end	

	def navigate_youtube_views
		@driver.navigate.to "http://kingdomlikes.com/free_points/youtube-views"
		sleep 3
	end	

	def perfom_login_page
		element_email = @driver.find_element(:name, 'email')
		element_password = @driver.find_element(:name, 'password')
		element_email.send_keys ARGV[0]
		element_password.send_keys ARGV[1]
		element_email.submit
	end	

	def try_find_like_button
		10.times do
			@driver.switch_to.window @driver.window_handles.last
			sleep 10
			element = @driver.find_element(:xpath, "//button[contains(.,'Like')]")
			pp element
			minutes = @driver.find_element(:xpath, "//h5[contains(.,'minutes')]")
			minutes_left = minutes.text[19..22]
			puts minutes_left
			element.click
			@driver.switch_to.window @driver.window_handles.last
			t = Time.parse("00:0"+minutes_left)
			s = t.hour * 60 * 60 + t.min * 60 + t.sec
			sleep s+5
			@driver.close
		end		
	end

end


s = LinkCrawler.new
s.start
s.navigate_index_page
s.perfom_login_page
s.navigate_youtube_views
s.try_find_like_button

