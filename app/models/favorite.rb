class Favorite < ApplicationRecord
  belongs_to :applicant
  belongs_to :head

  scope :search, ->(applicant_id, head_id){where('applicant_id = ? AND head_id = ? ', 
                    applicant_id, head_id).take}
end
