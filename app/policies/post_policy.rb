class PostPolicy < ApplicationPolicy

  def owner?
    user.owns?(record)
  end

  def destroy?
    user.admin? || user_match
  end

  def update?
    user.admin? || user_match
  end

  private

  def user_match
    user.id == record.user_id
  end
end
