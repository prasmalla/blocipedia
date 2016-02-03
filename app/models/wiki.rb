class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :history

  belongs_to :user

  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations

  validates :title, presence: :true
  validates :body, presence: :true

  def collaborator_for(user)
    collaborations.where(user: user).first
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
