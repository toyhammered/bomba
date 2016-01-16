class User < ActiveRecord::Base



  
  enum role: [:standard, :admin]
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :trackable, :validatable


  def set_default_role
    self.role ||= :standard
  end

end
