module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :youpi, String, null: false

    def youpi
      "you work"
    end
  end
end