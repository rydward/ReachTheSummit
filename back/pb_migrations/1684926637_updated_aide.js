migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7")

  // remove
  collection.schema.removeField("unne3fdo")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "unne3fdo",
    "name": "reponses",
    "type": "relation",
    "required": false,
    "unique": false,
    "options": {
      "collectionId": "szum4ve7lquagkn",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": [
        "id"
      ]
    }
  }))

  return dao.saveCollection(collection)
})
