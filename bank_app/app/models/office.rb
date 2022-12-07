class Office < ApplicationRecord
    has_many :schedules, dependent: :destroy

    validates :name, presence: { message: "Disculpe, el nombre de la sucursal no puede estar vacio" }
    validates :address, presence: { message: "Disculpe, la direccion de la sucursal no puede estar vacia" }
    validates :phone, presence: true, length: { minimum: 10, message: "Disculpe, el nro de tlf debe tener minimo 10 digitos" }
end
