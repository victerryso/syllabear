root = exports ? this

generateWords = ->
  sequences = Session.get('sequences')
  abc = []; bac = []

  until abc.length >= 10
    sample =
      a: _.sample sequences.a
      b: _.sample sequences.b
      c: _.sample sequences.c
    values = _.values(sample)
    starts = _.map values, (value) -> _.first(value)
    unless _.uniq(starts).length < 3
      word = values.join('')
      abc.push(word)
      _.uniq(abc)

  until bac.length >= 10
    sample =
      b: _.sample sequences.b
      a: _.sample sequences.a
      c: _.sample sequences.c
    values = _.values(sample)
    starts = _.map values, (value) -> _.first(value)
    unless _.uniq(starts).length < 3
      word = values.join('')
      bac.push(word)
      _.uniq(bac)

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
      $header.addClass('green')
    else
      $column.find('.selected').removeClass('done')
      $header.removeClass('green')

    if _.every(_.map sequences, (seq) -> seq.length >= 5)
      $('.checkmark').addClass('bounce animated')
      $('.checkmark').removeClass('disabled')
    else
      $('.checkmark').addClass('disabled')
      $('.checkmark').removeClass('bounce animated')

  'click .green.checkmark': (event) ->
    generateWords()
    Router.go('results')

  'click .blue.random': (event) ->
    randomWords()

  'click .red.remove': (event) ->
    $('.selected').trigger('click')

  'keydown .syllable-input': (event) ->
    if event.which is 13
      $target = $(event.target)
      string = $target.val().toLowerCase()
      $target.val('')

      syllable =
        sequence: @sequence
        strength: if @sequence is 'a' then 'strong' else 'weak'
        string: string

      existing = Syllables.findOne(syllable)
      if existing then Syllables.remove(existing._id) else Syllables.insert(syllable)