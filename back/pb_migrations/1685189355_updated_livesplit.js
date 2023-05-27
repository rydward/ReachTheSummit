migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("5c6ecvp4ag4zy7a")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "krlplbg7",
    "name": "user",
    "type": "relation",
    "required": false,
    "unique": false,
    "options": {
      "collectionId": "_pb_users_auth_",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": []
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("5c6ecvp4ag4zy7a")

  // remove
  collection.schema.removeField("krlplbg7")

  return dao.saveCollection(collection)
})
