# ** Attributes **
# user, current_user = current_user
# record = recipe

class RecipePolicy < ApplicationPolicy
  def new?
    current_user.persisted?
  end
  
  def create?
    record.user_id == current_user&.id
  end
  
  def edit?
    create?
  end
  
  def update?
    create?
  end
  
  def destroy?
    create?
  end
  
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end
end
