class NilClassPolicy < ApplicationPolicy
  def show?
    false
  end
  def index?
    show?
  end
  def update?
    true
  end
  def edit?
    update?
  end
  def new?
    false
  end
  def create?
    new?
  end
  def destroy?
    false
  end
end
