migrate((db) => {
  const collection = new Collection({
    "id": "07pmyhy3ug707fv",
    "created": "2023-05-10 13:19:03.048Z",
    "updated": "2023-05-10 13:19:03.048Z",
    "name": "sujet",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "9nskgois",
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
        "id": "jgg9eoay",
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
        "id": "7idyc5bq",
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
  const collection = dao.findCollectionByNameOrId("07pmyhy3ug707fv");

  return dao.deleteCollection(collection);
})
