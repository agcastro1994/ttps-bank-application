#Using 
#password: string -> virtual
#password_confirmation:string -> virtual

class User < ApplicationRecord
    has_secure_password :validations => false

    validates :email,  format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Direccion de correo invalida"}
    validates :password, length: { in: 8..30, message: "La clave debe tener entre 8 y 30 caracteres" }, confirmation: {message: "La clave y su confirmacion deben coincidir"}
    validates :password_confirmation, presence: {message: "Debe llenar el campo de confirmar clave"}

    def is_admin?
        return self.rol == 1
    end

    def is_operator?
        return self.rol == 2
    end
end
