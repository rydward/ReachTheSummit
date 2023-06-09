migrate((db) => {
  const collection = new Collection({
    "id": "siknsef2qly7owv",
    "created": "2023-05-10 13:18:09.430Z",
    "updated": "2023-05-10 13:18:09.430Z",
    "name": "guide",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "cwspkjde",
        "name": "titre",
        "type": "text",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "mmdvrkxm",
        "name": "texte",
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
  const collection = dao.findCollectionByNameOrId("siknsef2qly7owv");

  return dao.deleteCollection(collection);
})
