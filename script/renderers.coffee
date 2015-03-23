# global export
window.DefaultFormRenderer or= {}
window.BootstrapFormRenderer or= {}


###*
* Class which renders a Bootstrap form.
###
class window.DefaultFormRenderer

  ###*
   * Creates checkbox for given field name.
   * @param {string} Name of the field which will also be used as a name of the input.
  ###
  createCheckbox: (name) ->
    html = '<label><input type=\"checkbox\" name="' + name + '" /> ' + name + '</label>'
    return html

  ###*
   * Creates text field for given field name.
   * @param {string} Name of the field which will also be used as a name of the input.
   ###
  createText: (name) ->
    html = '<label for="' + name + '" class="col-sm-2 control-label"> ' + name.capitalize() + '</label>' +
        '<input type="text" name="' + name + '" class="form-control" placeholder="Enter ' +
        name.capitalize() + '" /></div>'
    return html

  ###*
   * Begins the form.
  ###
  beginForm: (name) ->
    html = "<h3>#{name}:</h3>"
    html = html + "<form>"
    return html

  ###*
   * Ends the form.
  ###
  endForm: (name) ->
    html = "</form>"
    return html


###*
   * Class which renders a Bootstrap form.
  ###
class window.BootstrapFormRenderer extends DefaultFormRenderer

  ###*
   * Creates checkbox for given field name.
   * @param {string} Name of the field which will also be used as a name of the input.
   ###
  createCheckbox: (name) ->
    html = '<div class="checkbox"><label><input type=\"checkbox\" name="' + name + '" /> ' + name + '</label></div>'
    return html

  ###*
   * Creates text field for given field name.
   * @param {string} Name of the field which will also be used as a name of the input.
   ###
  createText: (name) ->
    html = '<label for="' + name + '" class="col-sm-2 control-label"> ' + name.capitalize() + '</label>' +
        '<div class="col-sm-10"><input type="text" name="' + name + '" class="form-control" placeholder="Enter ' +
        name.capitalize() + '" /></div>'
    return html

  ###*
   * Begins the form.
  ###
  beginForm: (name) ->
    html = "<h3>#{name}:</h3>"
    html = html + "<form>"
    return html

  ###*
   * Ends the form.
  ###
  endForm: (name) ->
    html = "</form>"
    return html
