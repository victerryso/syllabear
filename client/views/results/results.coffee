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


Template.results.helpers
  lists: -> _.map Session.get('list'), (list, combo) -> combo: combo, list : list
  disableTable: -> unless Session.get('sequences') then 'disabled'
Template.results.events
  'click .red.left': -> Router.go('home')

  'click .green.folder': (event) ->
    $('.ui.basic.modal').modal('show')

  'click .blue.shuffle': (event) ->
    generateWords()
    Session.set('name', '')

