class Task < ApplicationRecord
  has_paper_trail

  belongs_to :taskable, polymorphic: true
end
