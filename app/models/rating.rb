class Rating < ApplicationRecord
  belongs_to :rated_user, class_name: 'User', foreign_key: 'rated_user_id'
  belongs_to :rater_user, class_name: 'User', foreign_key: 'rater_user_id'
  belongs_to :trade

end
