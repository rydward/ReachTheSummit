migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("18qzyy9m3j7uwrh")

  // remove
  collection.schema.removeField("oyibntem")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "iemaw9db",
    "name": "igt",
    "type": "number",
    "required": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("18qzyy9m3j7uwrh")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "oyibntem",
    "name": "igt",
    "type": "date",
    "required": false,
    "unique": false,
    "options": {
      "min": "",
      "max": ""
    }
  }))

  // remove
  collection.schema.removeField("iemaw9db")

  return dao.saveCollection(collection)
})
