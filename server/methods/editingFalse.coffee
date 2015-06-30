Meteor.methods
  editingFalse: ->
    Syllables.update({}, { $set: editing: null }, multi: true)