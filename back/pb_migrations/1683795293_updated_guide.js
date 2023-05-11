migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("siknsef2qly7owv")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "z323fajj",
    "name": "createur",
    "type": "relation",
    "required": true,
    "unique": false,
    "options": {
      "collectionId": "_pb_users_auth_",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": [
        "id"
      ]
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("siknsef2qly7owv")

  // remove
  collection.schema.removeField("z323fajj")

  return dao.saveCollection(collection)
})
