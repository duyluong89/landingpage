class Privilege < ActiveRecord::Base
  attr_accessible :controller, :description, :privilege, :task
end
