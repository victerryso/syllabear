root = exports ? this

root.Lists = new Mongo.Collection 'Lists'
Meteor.subscribe('Lists')

root.Lists.attachSchema(
  new SimpleSchema(

    name:
      type: String

    sequences:
      type: Object

    list:
      type: Object
  )
)

root.Lists.allow
  insert : -> true

  update : -> true

  remove : -> true