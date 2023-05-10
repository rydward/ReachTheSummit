migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "kxe2mbtn",
    "name": "titre",
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
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "kxe2mbtn",
    "name": "title",
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
