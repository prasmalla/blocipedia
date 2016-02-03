class User < ActiveRecord::Base
  # Other available devise modules are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :collaborations
  has_many :wikis, through: :collaborations
  after_initialize :set_role, if: :new_record?

  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def upgrade!
    update_attribute(:role, 'premium') unless admin?
  end

  def downgrade!
    unless admin?
      update_attribute(:role, 'standard') 
      self.wikis.where(private: true).each do |wiki|
        wiki.update_attribute(:private, false)
      end
    end
  end

private

  def set_role
    self.role = 'standard'
  end
end
