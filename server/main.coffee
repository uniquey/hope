Meteor.publish "bsckpisChannel" , -> 
		share.KPIs.find()

Meteor.publish "hospitalsChannel" , -> 
		share.Hospitals.find()

Meteor.methods
	removeFrom:(collection, id)->
		if share.adminLoggedIn
			collection.remove _id: id

	upsertTo: (collection, obj)-> 
		# each obj should have an indx; return Mongodb object _id
		if share.adminLoggedIn
			obj.createdOn = new Date
			share.consolelog collection.update indx: obj.indx ,
				obj, 
				upsert: true

	insertInto: (collection, obj)->
		if share.adminLoggedIn
			obj.createdOn = new Date
			collection.insert obj

	#--------------------------------------------------------

	removeKPI: (id)->
		removeFrom	share.KPIs, id 
	removeHospital: (id)->
		removeFrom	share.Hospitals, id 
	removeDepartment: (id)->
		removeFrom	share.Departments, id


	kpi: (obj)-> 
		upsertTo: share.KPIs, obj
	department: (obj)->
		upsertTo: share.Departments, obj
	hospital: (obj)->
		upsertTo: share.Hospitals, obj
		
			