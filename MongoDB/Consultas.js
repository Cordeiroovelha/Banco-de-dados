// 1. Atualizar os status
db.Consultas.updateMany(
  {_id: {$in: [6,7,8]}},
  {$set:{situacao:"Atendido"}}
)

db.Consultas.find(
  { _id: { $in: [6, 7, 8] } }
)


// 2. Duas novas Alas (Inserção múltipla)
db.Alas.insertMany([
    {
        _id: 6,
        Nome: "Psiquiatria",
        Procedimento: "Atendimento de saúde mental",
        Capacidade: null,  // Capacidade nula
        "hospital": {
            "_id": 1,
            "nome": "Hospital Da Paz"
    }
    },
    {
        _id: 7,
        Nome: "Ambulatório",
        Procedimento: "Atendimento ambulatorial",
        Capacidade: null,
        "hospital": {
            "_id": 1,
            "nome": "Hospital Da Paz"
    }
    }
]);

db.Alas.find();


// 3. Duas novas Alas (Inserção Individual)
db.Alas.insertOne({
    _id: 6,
    ID_Hospital: 1,
    Nome: "Psiquiatria",
    Procedimento: "Atendimento de saúde mental",
    Capacidade: null,
    "hospital": {
            "_id": 1,
            "nome": "Hospital Da Paz"
    }
});

db.Alas.insertOne({
    _id: 7,
    ID_Hospital: 1,
    Nome: "Ambulatório",
    Procedimento: "Atendimento ambulatorial",
    Capacidade: null,
    "hospital": {
            "_id": 1,
            "nome": "Hospital Da Paz"
    }
});

db.Alas.find();


// 4. Mudança de Alas (Inserção Individual)
db.Medicos.updateOne(
    { Ala: 2 },
    { $set: { Ala: 6 } }
);

db.Medicos.updateOne(
    { Ala: 5 },
    { $set: { Ala: 7 } }
);

db.Medicos.find({
    $or: [
        { Ala: 6 },
        { Ala: 7 }
    ]
});


// 5. Mudança de Alas (bulkWrite)
db.Medicos.bulkWrite([
  {
    updateMany: {
      filter: { "ala_id": 2 },
      update: { $set: { "ala_id": 6 } }
    }
  },
  {
    updateMany: {
      filter: { "_id": { $in: [8, 9] } },
      update: { $set: { "ala_id": 7 } }
    }
  }
]);

db.Medicos.find({
    Ala: { $in: [6, 7] }
}).pretty();


// 6. Número de consultas que existem e consultas que tem a situação como atendido
db.Consultas.countDocuments()
// Saida: 15

db.Consultas.countDocuments({ "situacao": "Atendido" })
// Saida: 10


// 7. Exclue as consultas que estão com a situação "Atendido"
db.Consultas.deleteMany({ "situacao": "Atendido" })