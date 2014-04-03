class InspectionOrderPolicy < ApplicationPolicy
  def edit?
    if super
      !record.inspected?
    end
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
