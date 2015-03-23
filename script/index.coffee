# String.capitalize
String.prototype.capitalize = () ->
  return this.charAt(0).toUpperCase() + this.slice(1)


# AJAX call
loadDataFromServer = (address, method, successCallback, errorCallback) ->
  req = new XMLHttpRequest()

  req.addEventListener 'readystatechange', ->
    if req.readyState is 4                        # ReadyState Complete
      successResultCodes = [200, 304]
      if req.status in successResultCodes
        successCallback req.responseText
      else
        errorCallback req.responseText

  req.open method, address, false
  req.send()


# global export of classes
window.FormCreator or= {}


###*
  * Class that creates forms from API calls.
 ###
class window.FormCreator

  @formRenderer: new DefaultFormRenderer()

  ###*
   * Sets form renderer.
   * @param {object} The form renderer, extending DefaultFormRenderer.
   ###
  @setFormRenderer: (formRenderer) ->
    FormCreator.formRenderer = formRenderer

  ###*
   * Creates form for given class.
   * @param {string} FQN of the class.
   * @param {function} Function that gets called when HTML is ready to be outputted.
   ###
  @create: (className, displayCallback) ->
    loadDataFromServer className + ".json", "GET",
      (
        (data) ->
          html = FormCreator.createFormFromJSON data, FormCreator.formRenderer
          displayCallback html
      ), (
        (textStatus) ->
          alert "AJAX Error: #{textStatus}"
      )

  ###*
   * Parses JSON and creates form.
   * @param {string} JSON to parse.
   ###
  @createFormFromJSON: (json, formRenderer) ->
    data = JSON.parse json
    html = formRenderer.beginForm data.name
    for field in data.fields
      html = html + InputFactory.createInput field.name, field.type, formRenderer
    html = html + formRenderer.endForm data.name


###*
  * Class which decides what methods to call on the FormRenderer
 ###
class InputFactory

  ###*
   * Creates input for the given field name and type.
   * @param {string} Name of the field.
   * @param {string} Type of the field.
   ###
  @createInput: (name, type, formRenderer) ->
    switch type
      when "boolean" then return formRenderer.createCheckbox name
      when "java.lang.String" then return formRenderer.createText name
