class Project < ApplicationRecord
  STATUSES = ["To Do", "In Progress", "Done"]

  include Versionable
  has_paper_trail
end
