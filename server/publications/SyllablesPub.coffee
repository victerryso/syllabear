root = exports ? this

Meteor.publish 'Syllables', -> root.Syllables.find()
Meteor.publish 'Lists', -> root.Lists.find()