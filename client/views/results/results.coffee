root = exports ? this

Template.results.helpers
  lists: -> _.map Session.get('list'), (list, combo) -> combo: combo, list : list

Template.results.events
  'click .blue.left': -> Router.go('home')

  'click .green.save': (event) ->
    $(event.target).addClass('disabled')

    Lists.insert
      sequences: Session.get('sequences')
      list: Session.get('list')

  'click .yellow.folder': (event) ->
    $('.ui.basic.modal').modal('show')

Template.modal.helpers
  savedLists: -> Lists.find()

Template.modal.events
  'click h3.header': (event) ->
    Session.set('sequences', @sequences)
    Session.set('list', @list)

    $('ui.modal').modal('hide')