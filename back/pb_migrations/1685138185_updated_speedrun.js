migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("18qzyy9m3j7uwrh")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "a3iks1xz",
    "name": "categorie",
    "type": "relation",
    "required": false,
    "unique": false,
    "options": {
      "collectionId": "j91ysndex17nwt2",
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
  const collection = dao.findCollectionByNameOrId("18qzyy9m3j7uwrh")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "a3iks1xz",
    "name": "categorie",
    "type": "relation",
    "required": true,
    "unique": false,
    "options": {
      "collectionId": "j91ysndex17nwt2",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": [
        "id"
      ]
    }
  }))

  return dao.saveCollection(collection)
})
