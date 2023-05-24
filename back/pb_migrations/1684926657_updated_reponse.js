migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("szum4ve7lquagkn")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "p6zvsonl",
    "name": "aide",
    "type": "relation",
    "required": false,
    "unique": false,
    "options": {
      "collectionId": "hjtqpkgxak2a5w7",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": []
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("szum4ve7lquagkn")

  // remove
  collection.schema.removeField("p6zvsonl")

  return dao.saveCollection(collection)
})
