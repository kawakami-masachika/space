class LikeShop < ApplicationRecord
  belongs_to :user
  belongs_to :shop, counter_cache: :likes_count
end
