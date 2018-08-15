class RideMatch < ApplicationRecord
  belongs_to :ride
  belongs_to :user
end
