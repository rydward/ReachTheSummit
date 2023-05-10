migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hph80rvqjx7mcr9")

  // remove
  collection.schema.removeField("tktfcrkv")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hph80rvqjx7mcr9")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tktfcrkv",
    "name": "field",
    "type": "text",
    "required": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
})
