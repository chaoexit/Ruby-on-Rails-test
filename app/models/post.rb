class Post < ActiveRecord::Base
	has_and_belongs_to_many :tags, -> { uniq }
end
