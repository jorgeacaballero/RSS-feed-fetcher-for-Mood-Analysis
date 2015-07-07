class Review < ActiveRecord::Base
	belongs_to :app
	validates_uniqueness_of :id
end
