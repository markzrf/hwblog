class Comment < ActiveRecord::Base
  attr_accessible :body, :id, :post
  belongs_to :post
  belongs_to :user
end
