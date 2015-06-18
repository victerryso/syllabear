root = exports ? this

# syllables =
#   a: ['bar', 'far', 'kar', 'dar', 'dee']
#   b: ['de', 'be', 'ke', 'ka', 'da']
#   c: ['fi', 'fa', 'bi', 'ba', 'di']

# generateWords = ->
#   sequences = Session.get('sequences')
#   abc = []; bac = []

#   _(10).times ->
#     word = ''
#     word = word + _.sample sequences.a
#     word = word + _.sample sequences.b
#     word = word + _.sample sequences.c
#     abc.push word

#   _(10).times ->
#     word = ''
#     word = word + _.sample sequences.b
#     word = word + _.sample sequences.a
#     word = word + _.sample sequences.c
#     bac.push word

#   Session.set('list', abc: abc, bac: bac)

# Session.set('sequences', syllables)
# generateWords()

Template.results.helpers
  sequences: ->
    sequences = Session.get('sequences')
    _.map sequences, (syllables, sequence) ->
      sequence : sequence
      syllables: syllables

  lists: ->
    lists = Session.get('list')
    _.map lists, (list, combo) ->
      combo: combo
      list : list
