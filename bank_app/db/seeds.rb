Schedule.destroy_all
Appointment.destroy_all
User.destroy_all
Office.destroy_all

offices = Office.create!([
    { 
        name: "Sucursal Central",
        address: "La Plata Centro, calle 50 #1234",
        phone: "2211234567",    
    },
    { 
        name: "Sucursal Calle 1",
        address: "La Plata, calle 1 #2000",
        phone: "2213456789",    
    },
    { 
        name: "Sucursal Buenos Aires",
        address: "Retiro, en la estacion del tren Roca",
        phone: "1112345678",    
    }
])

schedules = Schedule.create!([
    {
        start_at:"10:00",
        end_at:"15:00", 
        office_id:offices.first.id, 
        days:["Lunes","Martes","Viernes"]        
    },
    {
        start_at:"09:00",
        end_at:"16:00", 
        office_id:offices.first.id, 
        days:["Miercoles","Jueves"]        
    },
    {
        start_at:"11:00",
        end_at:"16:00", 
        office_id:offices.last.id, 
        days:["Lunes","Martes","Miercoles","Jueves","Viernes"]        
    },
    {
        start_at:"08:00",
        end_at:"14:00", 
        office_id: offices.second.id, 
        days:["Lunes","Martes","Miercoles"]        
    },
    {
        start_at:"09:00",
        end_at:"15:00", 
        office_id: offices.second.id, 
        days:["Jueves", "Viernes"]        
    },
    {
        start_at:"08:00",
        end_at:"12:00", 
        office_id: offices.second.id, 
        days:["Sabado"]        
    }
])

admins = User.create!([
    {
        email: "administrador@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:1, 
        offices_id: nil
    },
    {
        email: "superadmin@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:1, 
        offices_id: nil
    }
])

operators = User.create!([
    {
        email: "operator1@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:2, 
        offices_id: offices.last.id
    },
    {
        email: "operator2@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:2, 
        offices_id: offices.second.id
    },
    {
        email: "operator3@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:2, 
        offices_id: offices.second.id
    },
    {
        email: "operator4@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:2, 
        offices_id: offices.first.id
    },
    {
        email: "operator5@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:2, 
        offices_id: offices.first.id
    },
    {
        email: "operator6@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:2, 
        offices_id: offices.first.id
    }
])

clients = User.create!([
    {
        email: "cliente1@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:3, 
        offices_id: nil
    },
    {
        email: "cliente2@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:3, 
        offices_id: nil
    },
    {
        email: "cliente3@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:3, 
        offices_id: nil
    },
    {
        email: "cliente4@mail.com",
        password:"123456789", 
        password_confirmation:"123456789", 
        rol:3, 
        offices_id: nil
    }
])

#Office 1 only has one appointment (cancelled), can be erased if the operators are reassigned
appointments = Appointment.create!([
    {
        date:"15-12-2022",
        hour: "11:00",
        reason: "Extravio de tarjeta",
        status: 1,
        comment: nil,
        offices_id: offices.second.id,
        requester_id: clients.first.id,
        operator_id: nil
    },
    {
        date:"15-12-2022",
        hour: "11:00",
        reason: "Retirar TC",
        status: 1,
        comment: nil,
        offices_id: offices.second.id,
        requester_id: clients.second.id,
        operator_id: nil
    },
    {
        date:"12-12-2022",
        hour: "10:30",
        reason: "No llega mi tarjeta",
        status: 2,
        comment: "Error en la direccion de envio de la tarjeta. Problema resuelto, retiro por sucursal",
        offices_id: offices.second.id,
        requester_id: clients.first.id,
        operator_id: 4
    },
    {
        date:"16-12-2022",
        hour: "12:00",
        reason: "Retirar TC",
        status: 1,
        comment: nil,
        offices_id: offices.last.id,
        requester_id: clients.third.id,
        operator_id: nil
    },
    {
        date:"16-12-2022",
        hour: "13:30",
        reason: "Problemas de online banking",
        status: 1,
        comment: nil,
        offices_id: offices.last.id,
        requester_id: clients.last.id,
        operator_id: nil
    },
    {
        date:"26-12-2022",
        hour: "13:30",
        reason: "Problemas de online banking",
        status: 4,
        comment: nil,
        offices_id: offices.first.id,
        requester_id: clients.last.id,
        operator_id: nil
    }
])

p "Test data created"
