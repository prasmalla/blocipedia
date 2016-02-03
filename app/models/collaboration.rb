class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  validates :user, uniqueness: { scope: :wiki }
end
