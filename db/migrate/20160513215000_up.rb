class Up < ActiveRecord::Migration
  def up
    emp = Employee.new
    emp.first_name = "John"
    emp.last_name = "Mackie"
    emp.ssn = "123456723"
    emp.date_of_birth = Date.today - 18.years
    emp.phone = "5555555555"
    emp.role = "admin"
    emp.active = true
    emp.save!

    admin = User.new
    admin.email = "admin@example.com"
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.employee_id = emp.id
    admin.save!
  end

  def down

    admin = User.find_by_email "admin@example.com"
    User.delete admin
  end
end
