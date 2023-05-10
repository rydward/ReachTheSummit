migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "cjcykvvz",
    "name": "utilisateur",
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
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7")

  // remove
  collection.schema.removeField("cjcykvvz")

  return dao.saveCollection(collection)
})
