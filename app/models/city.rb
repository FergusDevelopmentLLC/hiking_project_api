class City < ApplicationRecord

    after_validation :set_slug, only: [:create, :update]
    has_and_belongs_to_many :trails

    private

    def set_slug
        self.slug = name.to_s.parameterize
    end 

end
