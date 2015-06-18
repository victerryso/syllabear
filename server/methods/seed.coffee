Meteor.methods
  seed: ->
    syllables =
      a: ['bar', 'far', 'kar', 'dar', 'dee', 'bee', 'fee', 'kee', 'dor', 'bor', 'for', 'kor', 'tar', 'tee', 'tor', 'par', 'pee', 'por', 'see', 'sor', 'sar', 'bur', 'sur', 'pur', 'tur', 'dur', 'fer', 'kur']
      b: ['de', 'be', 'ke', 'ka', 'da', 'fa', 'ba', 'fe', 'se', 'sa', 'te', 'ta', 'pe', 'pa']
      c: ['fi', 'fa', 'bi', 'ba', 'di', 'da', 'ki', 'ka', 'ti', 'ta', 'pi', 'pa', 'si', 'sa', 'ber', 'der', 'ker', 'per', 'ter', 'fer']

    _.each syllables, (array, sequence) ->
      strength = if sequence is 'a' then 'strong' else 'weak'
      _.each array, (syllable) ->
        Syllables.insert
          sequence: sequence
          strength: strength
          string  : syllable