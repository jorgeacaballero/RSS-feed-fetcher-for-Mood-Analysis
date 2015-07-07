class ReviewsController < ApplicationController

	def ngram
		#apps = App.all
		#apps.each{ |a|
			a = App.last
			p_revs = a.reviews.where('rating >= 3')
			n_revs = a.reviews.where('rating < 3')

			p_data = Array.new
			p_revs.each{ |r|
				p_data.push(r.content)
			}

			n_data = Array.new
			n_revs.each{ |r|
				n_data.push(r.content) 
			}
			p_gram = NGram.new(p_data, :n => [1,2,3])
			n_gram = NGram.new(n_data, :n => [1,2,3])

			p_gram = p_gram.ngrams_of_all_data[2].sort_by {|_key, value| value}
			p_gram = p_gram.reverse.first 10
			n_gram = n_gram.ngrams_of_all_data[2].sort_by {|_key, value| value}
			n_gram = n_gram.reverse.first 10

			#p_gram_2 = p_gram.ngrams_of_all_data[3].sort_by {|_key, value| value}
			#n_gram_2 = n_gram.ngrams_of_all_data[3].sort_by {|_key, value| value}

			#p_gram_2 = p_gram.ngrams_of_all_data[3].sort_by {|_key, value| value}
			#n_gram_2 = n_gram.ngrams_of_all_data[3].sort_by {|_key, value| value}

			render :json => {:positive => p_gram, 
                                  :negative => n_gram }
		#}
	end
end
