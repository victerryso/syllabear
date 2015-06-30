root = exports ? this

root.Lists = new Mongo.Collection 'Lists'
Meteor.subscribe('Lists')

root.Lists.attachSchema(
  new SimpleSchema(

    sequences:
      type: Object
      blackbox: true

    list:
      type: Object
      blackbox: true
  )
)

root.Lists.allow
  insert : -> true

  update : -> true

  remove : -> true