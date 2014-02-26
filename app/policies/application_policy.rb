class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "Debes estár autenticado." unless user
    @user = user
    @record = record
  end

  def method_missing(name, *args)
    if name.to_s.last == '?'
      check_permission(@user, @record, name)
    end
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  private
  def check_permission(user, resource, method_name)
    user.can?(infer_operation_from(method_name), infer_resource_from(resource))
  end
  def infer_operation_from(name)
    name.to_s.gsub('?', '')
  end
  def infer_resource_from(record)
    record.class.name.downcase
  end
end
