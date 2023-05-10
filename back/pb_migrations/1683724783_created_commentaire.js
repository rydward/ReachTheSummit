migrate((db) => {
  const collection = new Collection({
    "id": "tlmqdlnmr86wnzx",
    "created": "2023-05-10 13:19:43.420Z",
    "updated": "2023-05-10 13:19:43.420Z",
    "name": "commentaire",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "qcejhasw",
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
        "id": "pwk5nzxw",
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
  const collection = dao.findCollectionByNameOrId("tlmqdlnmr86wnzx");

  return dao.deleteCollection(collection);
})
