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

Template.results.events
  'click .red.left': -> Router.go('home')

  'click .yellow.folder': (event) ->
    $('.ui.basic.modal').modal('show')

  'click .blue.shuffle': (event) ->
    generateWords()


Template.modal.helpers
  savedLists: -> Lists.find()

Template.modal.events
  'click h3.header': (event) ->
    Session.set('sequences', @sequences)
    Session.set('list', @list)

    $('ui.modal').modal('hide')

  'keydown .save-list': (event) ->
    return unless event.which is 13
    name = $(event.target).val()
    $(event.target).val('')

    Lists.insert
      name: name
      sequences: Session.get('sequences')
      list: Session.get('list')

