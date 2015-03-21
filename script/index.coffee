$ = require 'jquery'


# String.capitalize
String.prototype.capitalize = () ->
  return this.charAt(0).toUpperCase() + this.slice(1)


# global export of FormCreator class
window.FormCreator or= {}


###*
  * Class that creates forms from API calls.
 ###
class window.FormCreator

  ###*
   * Creates form for given class.
   * @param {string} FQN of the class.
   ###
  @create: (className, displayCallback, inputWrapperCallback) ->
    $.ajax
      url: className + ".json"
      dataType: "html"
      error: (jqHXR, textStatus, errorThrown) ->
        alert "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        html = FormCreator.createFormFromJSON data, inputWrapperCallback
        displayCallback html

  ###*
   * Parses JSON and creates form.
   * @param {string} JSON to parse.
   ###
  @createFormFromJSON: (json, inputWrapperCallback) ->
    data = JSON.parse json
    html = "<h3>#{data.name}:</h3>"

    html = html + '<form role="form">'
    for field in data.fields
      html = html + InputCreator.createInput field.name, field.type, inputWrapperCallback
    html = html + '</form>'


class InputCreator

  ###*
   * Creates checkbox for given field name.
   * @param {string} Name of the field which will also be used as a name of the input.
   ###
  @createCheckbox: (name, wrapperCallback) ->
    html = '<div class="checkbox"><label><input type=\"checkbox\" name="' + name + '" /> ' + name + '</label></div>'
    if wrapperCallback then return wrapperCallback html else return html

  ###*
   * Creates text field for given field name.
   * @param {string} Name of the field which will also be used as a name of the input.
   ###
  @createText: (name, wrapperCallback) ->
    html = '<label for="' + name + '" class="col-sm-2 control-label"> ' + name.capitalize() + '</label>' +
        '<div class="col-sm-10"><input type="text" name="' + name + '" class="form-control" placeholder="Enter ' +
        name.capitalize() + '"/></div>'
    if wrapperCallback then return wrapperCallback html else return html

  ###*
   * Creates input for the given field name and type.
   * @param {string} Name of the field.
   * @param {string} Type of the field.
   ###
  @createInput: (name, type, wrapperCallback) ->
    switch type
      when "boolean" then return InputCreator.createCheckbox name, wrapperCallback
      when "java.lang.String" then return InputCreator.createText name, wrapperCallback