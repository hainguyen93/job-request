# list of rigs code
rig_list = 
  [ "11 - Site Including Offices", 
    "12 - AFTSTU", 
    "13 - APU", 
    "14 - Atmospheric Line", 
    "15 - Unit 5", 
    "16 - Fluidised Bed",
    "17 - Unit A1", 
    "18 - Furnace", 
    "19 - Solid Oxide Fuel Cell", 
    "20 - Wind Tunnel",
    "21 - Spray Rig", 
    "22 - MEL",
    "23 - 25kwair/oxyfuel PF Rig", 
    "24 - Elasticon Rig",
    "25 - L/sis",
    "26 - RTO",
    "27 - Fuel Filter Rig", 
    "28 - Unit A2",
    "29 - HiRETS", 
    "30 - Amine Capture Plant"]

rig_list.each do |name|
  Rig.create( code: name )
end


# CLIENT ADMIN ACCOUNT
User.create(username: "admin", 
            name:     "Administrator", 
            email:    "admin@sheffield.ac.uk",
            password: "password12345", 
            disabled: false,
            admin:    true,
            password_confirmation: "password12345")


