migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("j91ysndex17nwt2")

  collection.name = "categorie_speedrun"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("j91ysndex17nwt2")

  collection.name = "categorie"

  return dao.saveCollection(collection)
})
