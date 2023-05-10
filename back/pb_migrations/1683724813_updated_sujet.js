migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("07pmyhy3ug707fv")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "jskoyt75",
    "name": "commentaires",
    "type": "relation",
    "required": false,
    "unique": false,
    "options": {
      "collectionId": "tlmqdlnmr86wnzx",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": []
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("07pmyhy3ug707fv")

  // remove
  collection.schema.removeField("jskoyt75")

  return dao.saveCollection(collection)
})
