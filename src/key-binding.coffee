{normalizeKeystrokes, calculateSpecificity} = require './helpers'

module.exports =
class KeyBinding
  @currentIndex: 1

  enabled: true

  constructor: (@source, @command, keystrokes, selector) ->
    @keystrokes = normalizeKeystrokes(keystrokes)
    @keystroke = @keystrokes # deprecated property
    @keystrokeCount = @keystrokes.split(' ').length
    @selector = selector.replace(/!important/g, '')
    @specificity = calculateSpecificity(selector)
    @index = @constructor.currentIndex++

  matches: (keystroke) ->
    multiKeystroke = /\s/.test keystroke
    if multiKeystroke
      keystroke == @keystroke
    else
      keystroke.split(' ')[0] == @keystroke.split(' ')[0]

  compare: (keyBinding) ->
    if keyBinding.specificity is @specificity
      keyBinding.index - @index
    else
      keyBinding.specificity - @specificity
