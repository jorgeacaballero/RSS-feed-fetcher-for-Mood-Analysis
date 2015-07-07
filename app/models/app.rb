class App < ActiveRecord::Base
	has_many :reviews
	validates_uniqueness_of :id
end
