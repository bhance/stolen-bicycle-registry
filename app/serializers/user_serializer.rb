class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :country, :city, :region, :postal_code, 
             :phone1, :phone2, :email
end
