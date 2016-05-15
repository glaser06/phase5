class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :manager
      
      can :read, Employee do |e|
        e.current_assignment.store.id == user.employee.current_assignment.store.id
      end
      # can :read, Employee, :current_assignment => user.employee.current_assignment
      

      
      can :read, Store
      can :read, Job
      can :read, Flavor
      # can :read, Shift do |s| 
      #   s.store.id == user.employee.current_assignment.store.id
      # end
      can :manage, Shift do |s|
        s.store.id == user.employee.current_assignment.store.id
      end 
      can :manage, StoreFlavor do |s|
        s.store_id == user.employee.current_assignment.store_id
      end
      can :manage, ShiftJob do |s|
        s.store.id == user.employee.current_assignment.store_id
      end

      

    elsif user.role? :employee
      can :show, Employee, :id => user.employee_id
      can :update, Employee, :id => user.employee_id
      can :read, Store
      can :read, User, :employee_id => user.employee_id
      can :read, Assignment, :employee_id => user.employee_id
      can :read, Shift, :assignment_id => user.employee.current_assignment.id
      can :manage, User

      

    else
      cannot :manage, :all 
      can :manage, User
      can :read, Store
      cannot :read, Employee
      cannot :read, Shift
      

    end
  end
end
