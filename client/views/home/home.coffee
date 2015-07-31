root = exports ? this

randomWords = ->
  sequences = Session.get('sequences')
  _.each sequences, (list, sequence) ->
    count = list.length
    until count >= 5
      syllable = _.sample $(".#{sequence}-column").find('.statistic')
      unless $(syllable).hasClass('selected')
        $(syllable).trigger('click')
        count += 1

Template.home.helpers
  sequences: ->
    grouped = _.groupBy Syllables.find().fetch(), 'sequence'
    _.map grouped, (syllables, sequence) ->
      sequence : sequence
      syllables: _.sortBy syllables, 'string'

Template.home.rendered = ->
  Session.keys = {}
  Session.set('sequences', a: [], b: [], c: [])

Template.home.events
  'click .statistic': (event) ->
    $target   = $(event.target).closest('.statistic')
    $column   = $target.closest(".#{@sequence}-column")
    $header   = $column.find('.header')
    syllable  = this
    sequences = Session.get('sequences')
    sequence  = syllable.sequence
    list      = sequences[sequence]

    if $target.hasClass('selected')
      $target.removeClass('selected green')
      index = list.indexOf(syllable.string)
      list.splice(index, 1)
    else
      $target.addClass('selected')
      list.push(this.string)

    sequences[sequence] = list
    Session.set('sequences', sequences)

    if list.length >= 5
      $column.find('.selected').addClass('green')
      $header.addClass('green')
    else
      $column.find('.selected').removeClass('green')
      $header.removeClass('green')

    if _.every(_.map sequences, (seq) -> seq.length >= 5)
      $('.checkmark').addClass('bounce animated')
      $('.checkmark').removeClass('disabled')
    else
      $('.checkmark').addClass('disabled')
      $('.checkmark').removeClass('bounce animated')

  'click .green.checkmark': (event) ->
    $('.syllable').transition('fade', onComplete: -> Router.go('results'))

  'click .blue.random': (event) ->
    randomWords()

  'click .red.remove': (event) ->
    $('.selected').trigger('click')

  'click .yellow.edit': ->
    $('.syllable').transition('fade', onComplete: -> Router.go('edit'))
