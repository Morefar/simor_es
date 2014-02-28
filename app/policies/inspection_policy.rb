class InspectionPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :resource) do
    def resolve
      scope
    end
  end
end
