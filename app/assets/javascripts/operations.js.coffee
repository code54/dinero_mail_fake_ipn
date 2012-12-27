$(document).ready ->
  form = $('form#new_operation')
  addTransitonBtn = form.find('.add_transition')
  removeTransitonBtn = form.find('.remove_transition')
  transitions = form.find('tbody tr')

  transitions.filter(':not(:first-child)').hide()
  removeTransitonBtn.hide()

  addTransitonBtn.click (e) ->
    e.preventDefault()
    hiddenTransitions = transitions.filter(':not(:visible)')
    hiddenTransitions.first().show()
    removeTransitonBtn.show()
    addTransitonBtn.hide() if hiddenTransitions.size() == 1

  removeTransitonBtn.click (e) ->
    e.preventDefault()
    visibleTransitions = transitions.filter(':visible')
    visibleTransitions.last().hide()
    addTransitonBtn.show()
    removeTransitonBtn.hide() if visibleTransitions.size() == 2

  form.on 'submit', ->
    transitions.filter(':not(:visible)').detach()
