class WishKeyword < ApplicationRecord
  # Shows the association between that a wish belongs to a keyword
  # And a keyword belongs to a wish
  belongs_to :wish
  belongs_to :keyword
end
