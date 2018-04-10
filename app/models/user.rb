class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true
  has_secure_password
<<<<<<< HEAD
<<<<<<< HEAD

  enum role: [ "default", "admin" ]
=======
>>>>>>> f92b1d7... Add sessions#new view. Add users migration, controller, model, model tests for validations. Update routes
=======

  enum role: [ "default", "admin" ]
>>>>>>> 35448bd... Add role to users, update user_spec to test for default role.. Add dynamic nav logic to application_helper. Add nav views. Add basic styling to nav, header, form. Add user.rb to spec factories.
end
