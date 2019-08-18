class Category < ApplicationRecord
  has_many :products
  # has_many :brands,through: :categories_brands
  # has_many :categories_brands

  acts_as_nested_set counter_cache: :children_count
end
