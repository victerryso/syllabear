root = exports ? this

Meteor.publish 'Syllables', -> root.Syllables.find()