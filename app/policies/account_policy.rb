class AccountPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope
    end
  end
end