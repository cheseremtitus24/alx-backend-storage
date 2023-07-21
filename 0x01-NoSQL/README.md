# No SQL Databases
- MongoDB
Databases
- Collections are synonymous to RDBMS tables
- Collections do not enforce a schema therefore documents within a collection can have different fields.
- Documents are synomymous to RDBMS Table rows.
# Basic Commands:
- show dbs - shows all databases
- use <db_name> - switch to db_name
- db.createCollection("mycollection") - creates a collection
- show collections - show avail tables/collections
- db.<collection_name>.insert({"key":"value"}) - inserts a new document to collection 
- db.<collection_name>.insertMany([document1,document2]) - inserts multiple documents to collection 
- db.<collection_name>.estimatedDocumentCount() - counts the number of documents in a collection
- db.<collection_name>.find() - shows all documents in the collection
### Update Document
- db.mycol.update({'title':'MongoDB Overview'},{$set:{'title':'New MongoDB Tutorial'}})
- db.mycol.update({'title':'MongoDB Overview'},
   {$set:{'title':'New MongoDB Tutorial'}},{multi:true})
- db.empDetails.findOneAndUpdate(
	{First_Name: 'Radhika'},
	{ $set: { Age: '30',e_mail: 'radhika_newemail@gmail.com'}}
)
- db.empDetails.updateOne(
	{First_Name: 'Radhika'},
	{ $set: { Age: '30',e_mail: 'radhika_newemail@gmail.com'}}
)
- db.empDetails.updateMany(
	{Age:{ $gt: "25" }},
	{ $set: { Age: '00'}}
)

## Delete Document
- db.mycol.remove({'title':'MongoDB Overview'}) - remove all the documents whose title is 'MongoDB Overview'.
- db.COLLECTION_NAME.remove(DELETION_CRITERIA,1) - removes only 1
- db.mycol.remove({}) - Truncates the row

## Delete Collection
- db.<collection_name>.drop() - deletes a collection
## Delete Database
- db.dropDatabase() - will delete <db_name>

## Sorting in ascending and descending order -1 desc 1 asc
- db.mycol.find({},{"title":1,_id:0}).sort({"title":-1})

## Document Search/filter
- db.mycol.find({"by":"tutorials point"}).pretty() |  where by = 'tutorials point'
- db.mycol.find({"likes":{$lt:50}}).pretty() | where likes < 50
- db.mycol.find({"likes":{$lte:50}}).pretty() |	where likes <= 50
- db.mycol.find({"likes":{$gt:50}}).pretty() | where likes > 50
- db.mycol.find({"likes":{$gte:50}}).pretty() |	where likes >= 50
- db.mycol.find({"likes":{$ne:50}}).pretty() | where likes != 50
- db.mycol.find({"name":{$in:["Raj", "Ram", "Raghu"]}}).pretty() | Where name matches any of the value in :["Raj", "Ram", "Raghu"]
- db.mycol.find({"name":{$nin:["Ramu", "Raghav"]}}).pretty() | Where name values is not in the array :["Ramu", "Raghav"]
- db.mycol.find({ $and: [ {<key1>:<value1>}, { <key2>:<value2>} ] })
- db.mycol.find({$and:[{"by":"tutorials point"},{"title": "MongoDB Overview"}]}).pretty() | ' where by = 'tutorials point' AND title = 'MongoDB Overview' '
- db.mycol.find({$or:[{"by":"tutorials point"},{"title": "MongoDB Overview"}]}).pretty() 
- db.empDetails.find(
	{
		$nor:[
			40
			{"First_Name": "Radhika"},
			{"Last_Name": "Christopher"}
		]
	}
).pretty()
- db.empDetails.find( { "Age": { $not: { $gt: "25" } } } )
## Limiting Output (Offset/skip)
- db.mycol.find({},{"title":1,_id:0}).limit(2)
___
{"title":"MongoDB Overview"}
{"title":"NoSQL Overview"}
___
- db.mycol.find({},{"title":1,_id:0}).limit(1).skip(1)
___
{"title":"NoSQL Overview"}
___

## Creating Indexes
- db.<collection_name>.getIndexes() - Shows all indexes
- db.school.dropIndex({"Key_name":1}) - Drops an index
- db.school.dropIndex("name_1") - drop index based of index name. -need to run getIndexes() to get the name
- db.mycol.dropIndexes({"title":1,"description":-1}) - drops multiple indexes
- db.COLLECTION_NAME.createIndex({KEY:1}) - creates index in ascending form
---
db.mycol.createIndex({"title":1})

db.mycol.createIndex({"title":1,"description":-1})

---
## Aggregate Operation
`
{
   _id: ObjectId(7df78ad8902c)
   title: 'MongoDB Overview', 
   description: 'MongoDB is no sql database',
   by_user: 'tutorials point',
   url: 'http://www.tutorialspoint.com',
   tags: ['mongodb', 'database', 'NoSQL'],
   likes: 100
},

{
   _id: ObjectId(7df78ad8902d)
   title: 'NoSQL Overview', 
   description: 'No sql database is very fast',
   by_user: 'tutorials point',
   url: 'http://www.tutorialspoint.com',
   tags: ['mongodb', 'database', 'NoSQL'],
   likes: 10
},

{
   _id: ObjectId(7df78ad8902e)
   title: 'Neo4j Overview', 
   description: 'Neo4j is no sql database',
   by_user: 'Neo4j',
   url: 'http://www.neo4j.com',
   tags: ['neo4j', 'database', 'NoSQL'],
   likes: 750
},
`
- db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}]) | select by_user, count(*) from mycol group by by_user.

`{ "_id" : "tutorials point", "num_tutorial" : 2 }
{ "_id" : "Neo4j", "num_tutorial" : 1 }
`

