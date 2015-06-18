root = exports ? this

Template.header.events
  'click h1': -> Router.go('home')