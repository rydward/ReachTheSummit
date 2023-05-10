migrate((db) => {
  const collection = new Collection({
    "id": "xmvvedfwsxctf48",
    "created": "2023-05-10 11:49:03.651Z",
    "updated": "2023-05-10 11:49:03.651Z",
    "name": "role",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "juc8nzhx",
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
  const collection = dao.findCollectionByNameOrId("xmvvedfwsxctf48");

  return dao.deleteCollection(collection);
})
