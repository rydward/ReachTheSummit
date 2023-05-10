migrate((db) => {
  const collection = new Collection({
    "id": "szum4ve7lquagkn",
    "created": "2023-05-10 13:16:53.531Z",
    "updated": "2023-05-10 13:16:53.531Z",
    "name": "reponse",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "gzh6xtqx",
        "name": "texte",
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
        "id": "puara5lj",
        "name": "utilisateur",
        "type": "relation",
        "required": true,
        "unique": false,
        "options": {
          "collectionId": "_pb_users_auth_",
          "cascadeDelete": true,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": [
            "id"
          ]
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
  const collection = dao.findCollectionByNameOrId("szum4ve7lquagkn");

  return dao.deleteCollection(collection);
})
