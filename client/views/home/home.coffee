root = exports ? this

Session.keys =
  a: {}
  b: {}
  c: {}

Template.home.helpers
  sequences: ->
    grouped = _.groupBy Syllables.find().fetch(), 'sequence'
    _.map grouped, (syllables, sequence) ->
      sequence : sequence.toUpperCase()
      syllables: syllables

Template.home.rendered = ->

Template.home.events
  'click .syllable': (event) ->
    $target = $(event.target)
    sequence = Session.get(this.sequence)

    if $target.hasClass('selected')
      $target.removeClass('selected')
      $target.animate(opacity: 1)
      _.filter sequence, (syllable) -> this is syllable
    else
      $target.addClass('selected')
      $target.animate(opacity: 0.5)

