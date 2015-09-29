root = exports ? this

Meteor.publish 'Syllables', -> root.Syllables.find({}, sort: sequence: 1)
Meteor.publish 'Lists', -> root.Lists.find()
