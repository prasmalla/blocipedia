class User < ActiveRecord::Base
  # Other available devise modules are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :wikis
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
    self.update_attribute(:role, 'premium') unless admin?
  end

  def downgrade!
    self.update_attribute(:role, 'standard') unless admin?
  end

  private

    def set_role
      self.role = "standard"
    end
end
