migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("5c6ecvp4ag4zy7a")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "nv5kw3iw",
    "name": "forsaken_city",
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
  const collection = dao.findCollectionByNameOrId("5c6ecvp4ag4zy7a")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "nv5kw3iw",
    "name": "forsalen_city",
    "type": "number",
    "required": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null
    }
  }))

  return dao.saveCollection(collection)
})
