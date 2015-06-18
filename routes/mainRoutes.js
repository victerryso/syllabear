Router.route('home', {
  path: '/',
  waitOn: function() {
    return [
      Meteor.subscribe('Syllables')
    ];
  }
})
