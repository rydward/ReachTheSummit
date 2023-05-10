migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "zxwbvb5g",
    "name": "niveau",
    "type": "relation",
    "required": false,
    "unique": false,
    "options": {
      "collectionId": "hph80rvqjx7mcr9",
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
  collection.schema.removeField("zxwbvb5g")

  return dao.saveCollection(collection)
})
