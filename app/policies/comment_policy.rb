class CommentPolicy < ApplicationPolicy
  def edit?
    user.can?(:edit, :comment) && record.user == user
  end

  def update?
    edit?
  end
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope
    end
  end
end
