Router.route('home', {
  path: '/',
  waitOn: function() {
    return [
      Meteor.subscribe('Syllables'),
      Meteor.subscribe('Lists')
    ];
  }
})

Router.route('results', {
  path: '/results',
  waitOn: function() {
    return [
      Meteor.subscribe('Syllables'),
      Meteor.subscribe('Lists')
    ];
  }
})

Router.route('edit', {
  path: '/edit',
  waitOn: function() {
    return [
      Meteor.subscribe('Syllables'),
      Meteor.subscribe('Lists')
    ];
  }
})
