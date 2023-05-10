migrate((db) => {
  const collection = new Collection({
    "id": "azmk4h0iq93xndr",
    "created": "2023-05-10 13:13:48.082Z",
    "updated": "2023-05-10 13:13:48.082Z",
    "name": "actualite",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "ejxq66wu",
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
        "id": "w6j6s9e8",
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
        "id": "8hhax4em",
        "name": "createur",
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
  const collection = dao.findCollectionByNameOrId("azmk4h0iq93xndr");

  return dao.deleteCollection(collection);
})
