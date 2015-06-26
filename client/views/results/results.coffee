root = exports ? this

Template.results.helpers
  lists: -> _.map Session.get('list'), (list, combo) -> combo: combo, list : list

Template.results.events
  'click .left.blue': -> Router.go('home')
