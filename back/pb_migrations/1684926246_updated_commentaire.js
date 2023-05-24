migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tlmqdlnmr86wnzx")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ovdb33gy",
    "name": "sujet",
    "type": "relation",
    "required": false,
    "unique": false,
    "options": {
      "collectionId": "07pmyhy3ug707fv",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": []
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tlmqdlnmr86wnzx")

  // remove
  collection.schema.removeField("ovdb33gy")

  return dao.saveCollection(collection)
})
