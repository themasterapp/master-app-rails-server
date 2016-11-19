class UserPolicy < ApplicationPolicy
  def index?
    current_user.admin?
  end

  def show?
    current_user.admin? or current_user == record
  end

  def update?
    return false if current_user == record

    current_user.admin?
  end

  def destroy?
    return false if current_user == record

    current_user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end
end
