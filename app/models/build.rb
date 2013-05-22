
class Build < ActiveRecord::Base
  attr_accessible :body_id, :kind_id

  belongs_to :kind
  belongs_to :body

  validates :body_id, :kind_id, presence: true


  def self.authorized_build? (kind, body)
    return Build.where(body_id: body, kind_id: kind).exists?
  end
end
