class Task < ApplicationRecord

  belongs_to :taskable, polymorphic: true
  scope :undeleted, -> { where(deleted: false) }
end
