class ActiveRecord::Base
  def self.sample
    offset(rand(0..(count-1))).first
  end

  def self.[](id)
    find_by_id(id)
  end
end
