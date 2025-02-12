class Comment < ApplicationRecord
  include Versionable
  has_paper_trail
  belongs_to :project
end
