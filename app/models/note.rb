class Note < ApplicationRecord
  has_paper_trail

  belongs_to :noteable, polymorphic: true
end
