Router.route('home', {
  path: '/',
  waitOn: function() {
    return [
      Meteor.subscribe('Syllables')
    ];
  }
})

Router.route('results', {
  path: '/results',
  waitOn: function() {
    return [
      Meteor.subscribe('Syllables')
    ];
  }
})

Router.route('edit', {
  path: '/edit',
  waitOn: function() {
    return [
      Meteor.subscribe('Syllables')
    ];
  }
})
