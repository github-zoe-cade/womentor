# model BDD : User
# adapter/mapper : UserToMentor
# model metier : Mentor

class Mentor

  attr_accessor :name, :mentee_capacity

  def initialize(name: , mentee_capacity:)
    @name = name
    @mentee_capacity = mentee_capacity
  end
end
