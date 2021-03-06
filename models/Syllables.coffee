root = exports ? this

root.Syllables = new Mongo.Collection 'Syllables'
Meteor.subscribe('Syllables')

root.Syllables.attachSchema(
  new SimpleSchema(

    strength:
      type: String

    sequence:
      type: String

    string:
      type: String

    editing:
      type: Boolean
      optional: true

  )
)

root.Syllables.allow
  insert : -> true

  update : -> true

  remove : -> true