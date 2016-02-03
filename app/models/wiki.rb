class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, presence: :true
  validates :body, presence: :true

  def collaborator_for(user)
    collaborations.where(user: user).first
  end
end
