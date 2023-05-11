migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("_pb_users_auth_")

  // remove
  collection.schema.removeField("ybaonzoz")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "wkwomjyc",
    "name": "role",
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
  const collection = dao.findCollectionByNameOrId("_pb_users_auth_")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ybaonzoz",
    "name": "role",
    "type": "relation",
    "required": true,
    "unique": false,
    "options": {
      "collectionId": "xmvvedfwsxctf48",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": [
        "id"
      ]
    }
  }))

  // remove
  collection.schema.removeField("wkwomjyc")

  return dao.saveCollection(collection)
})
