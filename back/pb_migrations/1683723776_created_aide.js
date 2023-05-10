migrate((db) => {
  const collection = new Collection({
    "id": "hjtqpkgxak2a5w7",
    "created": "2023-05-10 13:02:56.914Z",
    "updated": "2023-05-10 13:02:56.914Z",
    "name": "aide",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "yamxew59",
        "name": "type",
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
        "id": "kxe2mbtn",
        "name": "title",
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
  const collection = dao.findCollectionByNameOrId("hjtqpkgxak2a5w7");

  return dao.deleteCollection(collection);
})
