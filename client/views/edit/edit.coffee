root = exports ? this

Template.edit.helpers
  sequences: ->
    grouped = _.groupBy Syllables.find().fetch(), 'sequence'
    _.map grouped, (syllables, sequence) ->
      sequence : sequence
      syllables: _.sortBy syllables, 'string'

Template.edit.rendered = ->
  Meteor.call('editingFalse')

Template.edit.events
  'click .blue.edit': (event) ->
    id = @_id
    Syllables.update(id, $set: editing: true)
    focus = -> $("##{id}").focus()
    setTimeout(focus, 100)

  'keydown input': (event) ->
    if event.which is 13
      $target = $(event.target)
      string = $target.val()

      if @_id
        Syllables.update(@_id, $set: string: string, editing: null)
      else
        $target.val('')
        Syllables.insert
          sequence: @sequence
          strength: if @sequence is 'a' then 'strong' else 'b'
          string: string

  'click .red.remove': (event) -> Syllables.remove(@_id)

  'click .red.left': -> Router.go('home')
