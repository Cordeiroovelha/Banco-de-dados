//Pacientes
db.Pacientes.insertOne({
  "_id": 1,
  "nome": "Jose da Silva",
  "Idade": 45,
  "contatoEmergencia": "(11)98765-4321",
  "tipoSanguinio": "O-",
  "prioridade": 2,
  "descricao": "Dor de cabeça"
})

//Hospital
db.Hospital.insertOne({
  "_id": 1,
  "nome": "Hospital Da Paz",
  "endereco": "Rua das Flores, 123, São Paulo",
  "telefone": "(11)1234-5678",
  "email": "hospitaldapaz@gmail.com"
})

// Medicos
db.Medicos.insertOne({
  "_id": 1,
  "nome": "Dr. Augusto Manzano",
  "especialidade": "Obstetrícia",
  "ala_id": 3,
  "hospital_id": 1,
})

// Alas
db.Alas.insertOne({
  "_id": 1,
  "nome": "Emergencia",
  "capacidade": 20,
  "procedimento": "Casos Graves e Urgentes",
  "hospital": {
    "_id": 1,
    "nome": "Hospital Da Paz"
   }
})

// Consultas
db.Consultas.insertOne ({
  "_id": 1,
  "paciente_id": 3,
  "medico_id": 2,
  "data": ISODate("2024-11-20"),
  "situacao": "Atendido",
  "ala_id": 1
})
