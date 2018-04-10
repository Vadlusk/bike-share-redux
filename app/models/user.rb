class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true
  has_secure_password
<<<<<<< HEAD

  enum role: [ "default", "admin" ]
=======
>>>>>>> f92b1d7... Add sessions#new view. Add users migration, controller, model, model tests for validations. Update routes
end
