require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name, @funding, @salaries = name, funding, salaries
        @employees = []
    end

    def valid_title?(title)
        return true if @salaries.include?(title)
        false
    end

    def >(other_startup)
        self.funding > other_startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise ArgumentError.new "Invalid Title name"
        end
    end

    def size 
        @employees.length
    end

    def pay_employee(employee)
        if @funding > @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise "Unable to fund #{employee.name}"
        end
    end

    def payday
        @employees.each {|name| pay_employee(name)}
    end

    def average_salary  
        sum = 0
        @employees.each {|name| sum += @salaries[name.title]}
        sum / @employees.length
    end

    def close
        @employees, @funding = [], 0
    end

    def acquire(startup)
        @funding += startup.funding
        acquired_hash = startup.salaries

        acquired_hash.each do |title, salary|
            @salaries[title] = salary if !@salaries.include?(title)
        end

        @employees += [*startup.employees]
        startup.close
    end




end
