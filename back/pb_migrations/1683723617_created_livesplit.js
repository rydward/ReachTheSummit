migrate((db) => {
  const collection = new Collection({
    "id": "5c6ecvp4ag4zy7a",
    "created": "2023-05-10 13:00:17.537Z",
    "updated": "2023-05-10 13:00:17.537Z",
    "name": "livesplit",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "jiyikhmh",
        "name": "temps_total",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "dvl8xgsr",
        "name": "prologue",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "nv5kw3iw",
        "name": "forsalen_city",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "ulnztsq7",
        "name": "old_site",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "v9dpqeyj",
        "name": "celestial_resort",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "mrp6rdwd",
        "name": "golden_ridge",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "yv5gfimf",
        "name": "mirror_temple",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "p0fjgfta",
        "name": "reflection",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
        }
      },
      {
        "system": false,
        "id": "ezn7jlb5",
        "name": "the_summit",
        "type": "number",
        "required": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null
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
  const collection = dao.findCollectionByNameOrId("5c6ecvp4ag4zy7a");

  return dao.deleteCollection(collection);
})
