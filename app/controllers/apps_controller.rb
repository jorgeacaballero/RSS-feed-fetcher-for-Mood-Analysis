class AppsController < ApplicationController
	require "uri"
	require "net/http"
	require "erb"
	include ERB::Util

	def index
		apps = App.all
		render json: apps
	end

	def fetch
		url = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/xml"
		feed = Feedjira::Feed.fetch_and_parse url

		feed = feed.entries.entries
		feed.each { |e|  
			a = App.new({
				id: e.entry_id[/.*\/id([0-9]*)/,1],
				name: e.title
			})
			if a.valid?
				if a.save
					url_r = "http://ax.itunes.apple.com/US/rss/customerreviews/id=#{a.id}/sortBy=mostRecent/xml"
					Feedjira::Feed.add_common_feed_entry_element('im:rating', :as => :rating)
					revs = Feedjira::Feed.fetch_and_parse url_r
					revs = revs.entries.entries.to_a
					revs.shift
					revs.each { |r|						
						r = Review.new({
							id: r.entry_id,
							title: r.title,
							content: r.content,
							rating: r.rating,
							app_id: a.id
						})
						if r.valid?
							r.save
						end
					}
				end
			end
		}
		apps = App.all
		render :json => apps.to_json(:include => [:reviews])
	end

	
end
