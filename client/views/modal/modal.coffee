root = exports ? this

Template.modal.helpers
  savedLists: -> Lists.find()
  sequenceName: -> Session.get('name')
  sequences: ->
    object = Session.get('sequences')
    _.map object, (value, key) ->
      sequence: key
      syllables: value

Template.modal.events
  'click .load-list': (event) ->
    Session.set('sequences', @sequences)
    Session.set('list', @list)
    Session.set('name', @name)

  'keydown .save-list': (event) ->
    return unless event.which is 13
    name = $(event.target).val()
    return unless name
    $(event.target).val('')

    Lists.insert
      name: name
      sequences: Session.get('sequences')
      list: Session.get('list')

  'click .red.remove': -> Lists.remove(@_id); false