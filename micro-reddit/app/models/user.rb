class User < ActiveRecord::Base
  VALID_LINK_REGEX = /\A[a-z\d\-.\/:]+\.[a-z\/]+\z/i
  validates :link, presence: true,
    format: { with: VALID_LINK_REGEX }
end
