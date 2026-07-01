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


// 8. consulta que associa o nomes dos medicos com o id das consultas 
db.Consultas.aggregate([
  {
    $lookup: {
      from: "Medicos",
      localField: "medico_id",
      foreignField: "_id",
      as: "medico"
    }
  },
  { $unwind: "$medico" },
  {
    $project: {
      idConsulta: "$_id",
      nomeMedico: "$medico.nome",
      _id: 0
    }
  },
]);

// 9. Ordenação de pacientes por ordem alfabética
db.Pacientes.find().sort({ Nome: 1 })

// 10. insere um novo paciente
db.Pacientes.insertMany([
  {
    _id: 16,
    Nome: "João Silva",
    Idade: 25,
    contatoEmergencia: "(11)99999-1111",
    TipoSanguinio: "O+",
    Prioridade: 2,
    Descricao: "Dor de garganta"
  },
  {
    _id: 17,
    Nome: "Maria Silva",
    Idade: 34,
    contatoEmergencia: "(11)99999-2222",
    TipoSanguinio: "A+",
    Prioridade: 1,
    Descricao: "Febre e dor de cabeça"
  },
  {
    _id: 18,
    Nome: "Pedro Silva",
    Idade: 42,
    contatoEmergencia: "(11)99999-3333",
    TipoSanguinio: "B+",
    Prioridade: 2,
    Descricao: "Dores musculares"
  }
]);

// 11. Filtrar pacientes com sobrenome Silva
db.Pacientes.find({ Nome: { $regex: "Silva$", $options: "i" } })

// 12. Numero de consultas em atendimento por ala
db.Alas.aggregate([
  {
    $lookup: {
      from: "Consultas",
      let: { alaId: "$_id" },
      pipeline: [
        { $match: { $expr: { $eq: ["$ala_id", "$$alaId"] } } },
        { $match: { situacao: "Em atendimento" } }
      ],
      as: "consultasEmAtendimento"
    }
  },
  {
    $project: {
      alaId: "$_id",
      nomeAla: "$nome",
      pacientesEmAtendimento: { $size: "$consultasEmAtendimento" }
    }
  },
  { $sort: { nomeAla: 1 } }
]);

// 13. Carga horaria dos medicos
db.Consultas.aggregate( [ {
    $group: {
      _id: "$medico_id",
      totalConsultas: { $sum: 1 }
  }
  }, {
    $lookup: {
      from: "Medicos",
      localField: "_id",
      foreignField: "_id",
      as: "medico"
    } },
  { $unwind: "$medico" },
  {
    $project: {
      _id: 0,
      medicoId: "$_id",
      nomeMedico: "$medico.nome",
      especialidade: "$medico.especialidade",
      totalConsultas: 1
    }
  },
]);

// 14. deleta pacientes individualmente
db.Pacientes.deleteOne({ _id: 16 });
db.Pacientes.deleteOne({ _id: 17 });
db.Pacientes.deleteOne({ _id: 18 });

// 15. deleta pacientes em massa
db.Pacientes.deleteMany({ _id: { $in: [16, 17, 18] } });

// 16. Criação de variavel
var p1 = db.Pacientes.findOne({ _id: 1 });

// 17. Comparação de dois valores
var p1 = db.Pacientes.findOne({ _id: 1 });
var p2 = db.Pacientes.findOne({ _id: 2 });

if (!p1 || !p2) {
  print("Um dos pacientes não foi encontrado.");
} else if (p1.Idade > p2.Idade) {
  printjson(p1);
} else if (p2.Idade > p1.Idade) {
  printjson(p2);
} else {
  print("As idades são iguais.");
}

// 18. Função de comparação de idade
function getIdade(id1, id2) {
    var p1 = db.Pacientes.findOne({ _id: id1 });
    var p2 = db.Pacientes.findOne({ _id: id2 });

    if (!p1 || !p2) {
        print("Um dos pacientes não foi encontrado.");
        return null;
    }

    if (p1.Idade > p2.Idade) {
        return p1;
    } else if (p2.Idade > p1.Idade) {
        return p2;
    } else {
        print("As idades são iguais.");
        return p1; // ou p2, ambos têm a mesma idade
    }
}

var maisVelho = getIdade(1, 2);
printjson(maisVelho);

// 19. função que retorna quantidade de consultas
function cargaMedico(idMedico) {
    return db.Consultas.countDocuments({ medico_id: idMedico });
}

// 20.
function cargaMedico(idMedico) {
    return db.Consultas.countDocuments({ medico_id: idMedico });
}
var total = cargaMedico(1);
print("Total de consultas: " + total);

// 21. 
function medicoMaisOcupado() {
    var medicos = db.Medicos.find().toArray();
    var maxCarga = -1;
    var medicoTop = null;

    for (var i = 0; i < medicos.length; i++) {
        var carga = cargaMedico(medicos[i]._id);
        if (carga > maxCarga) {
            maxCarga = carga;
            medicoTop = medicos[i];
        }
    }

    if (medicoTop) {
        print("Médico mais ocupado: " + medicoTop.nome + " com " + maxCarga + " consultas.");
    } else {
        print("Nenhum médico encontrado.");
    }
}
medicoMaisOcupado();

// 22.
db.Alas.updateMany(
  {},
  { $inc: { capacidade: 10 } }
);

// 23.
db.Alas.updateOne(
  { _id: 5 },
  { $inc: { capacidade: -20 } }
);

// 24.
// mongodump --db Hospital --out "C:\Users\Murilo Cordeiro\Downloads\backup"

// 25.
// mongoexport --db Hospital --collection Pacientes --out 
// "C:\Users\Murilo Cordeiro\Downloads\pacientes_backup.json"

// 26.
db.Pacientes.find({
  $or: [
    { Idade: { $gt: 50 } },
    { TipoSanguinio: "O-" }
  ]
});

// 27. 
db.Pacientes.find({
  idade: { $gt: 50 },
  $nor: [
    { tipoSanguinio: "O-" }
  ]
});

