class Office < ApplicationRecord
    has_many :schedules, dependent: :destroy

    validates :name, presence: { message: "Disculpe, el nombre de la sucursal no puede estar vacio" }
    validates :address, presence: { message: "Disculpe, la direccion de la sucursal no puede estar vacia" }
    validates :phone, presence: true, length: { minimum: 9, message: "Disculpe, el nro de tlf debe tener minimo 9 digitos" }, format: { with: /\A(\+\d{1,2}\s)?\(?\d{2,3}\)?[\s.-]?\d{3,4}[\s.-]?\d{4}/, message: "El numero de telefono no cumple el formato" }

    def get_offices_names
        offices_names = []
        all_offices = Office.all

        all_offices.each do |office|
            offices_names.append([office.name, office.id])
        end
        return offices_names
    end
end
