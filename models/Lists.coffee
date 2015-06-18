root = exports ? this

root.Lists = new Mongo.Collection 'Lists'
Meteor.subscribe('Lists')

root.Lists.attachSchema(
  new SimpleSchema(

    abc:
      type: [String]

    bac:
      type: [String]

  )
)

root.Lists.allow
  insert : -> true

  update : -> true

  remove : -> true