root = exports ? this

generateWords = ->
  sequences = Session.get('sequences')
  abc = []; bac = []

  _(10).times ->
    word = ''
    word = word + _.sample sequences.a
    word = word + _.sample sequences.b
    word = word + _.sample sequences.c
    abc.push word

  _(10).times ->
    word = ''
    word = word + _.sample sequences.b
    word = word + _.sample sequences.a
    word = word + _.sample sequences.c
    bac.push word

  Session.set('list', abc: abc, bac: bac)

randomWords = ->
  sequences = Session.get('sequences')
  _.each sequences, (list, sequence) ->
    count = list.length
    until count >= 5
      syllable = _.sample $(".#{sequence}-column").find('.syllable')
      unless $(syllable).hasClass('selected')
        $(syllable).trigger('click')
        count += 1

Template.home.helpers
  sequences: ->
    grouped = _.groupBy Syllables.find().fetch(), 'sequence'
    _.map grouped, (syllables, sequence) ->
      sequence : sequence
      syllables: syllables

Template.home.rendered = ->
  Session.keys = {}
  Session.set('sequences', a: [], b: [], c: [])

Template.home.events
  'click .syllable': (event) ->
    $target   = $(event.target)
    $column   = $target.closest('.column')
    $header   = $column.find('.header')
    syllable  = this
    sequences = Session.get('sequences')
    sequence  = syllable.sequence
    list      = sequences[sequence]

    if $target.hasClass('selected')
      $target.removeClass('selected done')
      $target.animate(opacity: 1)
      index = list.indexOf(syllable.string)
      list.splice(index, 1)
    else
      $target.addClass('selected')
      $target.animate(opacity: 0.5)
      list.push(this.string)

    sequences[sequence] = list
    Session.set('sequences', sequences)

    if list.length >= 5
      $column.find('.selected').addClass('done')
      $header.addClass('done')
    else
      $column.find('.selected').removeClass('done')
      $header.removeClass('done')

    if _.every(_.map sequences, (seq) -> seq.length >= 5)
      $('.checkmark').removeClass('disabled')
    else
      $('.checkmark').addClass('disabled')

  'click .green.checkmark': (event) ->
    generateWords()
    Router.go('results')

  'click .blue.random': (event) ->
    randomWords()

  'click .red.remove': (event) ->
    $('.selected').trigger('click')