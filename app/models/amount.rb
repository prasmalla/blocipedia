class Amount < ActiveRecord::Base
  def self.default
    15*1_00
  end
end
