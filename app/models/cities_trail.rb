class CitiesTrail < ApplicationRecord
    belongs_to :city
    belongs_to :trail
end
