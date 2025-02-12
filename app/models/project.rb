class Project < ApplicationRecord
  STATUSES = ["To Do", "In Progress", "Done"]

  include Versionable
  has_paper_trail

  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true
end
