class BicycleSerializer < ActiveModel::Serializer
  attributes :date, :city, :region, :postal_code, :serial,
             :police_report, :description, :reward, :brand, :model,
             :color, :size, :size_type, :country,
             :user_id, :year
end
