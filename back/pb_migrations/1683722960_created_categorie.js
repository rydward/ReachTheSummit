migrate((db) => {
  const collection = new Collection({
    "id": "j91ysndex17nwt2",
    "created": "2023-05-10 12:49:20.080Z",
    "updated": "2023-05-10 12:49:20.080Z",
    "name": "categorie",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "usvacrvt",
        "name": "libelle",
        "type": "text",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("j91ysndex17nwt2");

  return dao.deleteCollection(collection);
})
