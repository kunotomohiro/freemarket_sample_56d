class SnsCredential < ApplicationRecord
  belongs_to :user
  validates :uid, :provider, presence: true
end
