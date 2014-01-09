class Build < ActiveRecord::Base
  belongs_to :kind
  belongs_to :body

  validates :body_id, :kind_id, presence: true
  validates :kind_id, uniqueness: { scope: :body_id}


  def self.authorized_build? (kind, body)
    return Build.where(body_id: body, kind_id: kind).exists?
  end
end
