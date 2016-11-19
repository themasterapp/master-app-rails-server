class Recipe < ApplicationRecord
  extend FriendlyId
  
  SLUG_CANDIDATES = [:title, [:title, :id]].freeze
  
  friendly_id :slug_candidates, use: [:slugged, :finders]
  
  belongs_to :user

  validates :title, :ingredients, :instructions, presence: true
  
  protected
  
  def slug_candidates
    SLUG_CANDIDATES
  end
end
