migrate((db) => {
  const collection = new Collection({
    "id": "hph80rvqjx7mcr9",
    "created": "2023-05-10 13:03:23.975Z",
    "updated": "2023-05-10 13:03:23.975Z",
    "name": "niveau",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "zdv7jisr",
        "name": "nom",
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
        "id": "tktfcrkv",
        "name": "field",
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
  const collection = dao.findCollectionByNameOrId("hph80rvqjx7mcr9");

  return dao.deleteCollection(collection);
})
