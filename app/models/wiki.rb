class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :visible_to, -> (user) { user.try(:admin?) || user.try(:premium?) ? all : where(private: false) }
end
