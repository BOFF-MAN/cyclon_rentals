class BikePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user_or_admin
  end

  def destroy?
    user_or_admin
  end

  private

  def user_or_admin
    # if the user is the owner of the bike => true
    # Otherwise => false
    # user => current_user
    # record => @bike (argument passed to 'authorize')
    user == record.user || user.admin
  end
end
