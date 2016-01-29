class UserPolicy < ApplicationPolicy

  def update?
    user.id == record.id
  end

  def owner?
    user == record
  end

end
