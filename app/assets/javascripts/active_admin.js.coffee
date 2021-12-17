#= require active_admin/base
#= require select2/select2.min
#= require jquery-ui/ui/i18n/datepicker-fr

select2Options = (opts = {}) ->

  resultFormat = (data) ->
    eval opts.resultFormat

  width: opts.width || "240px"
  placeholder: opts.placeholder || "Select #{opts.resourceName}"
  minimumInputLength: opts.minimumInputLength || 3
  allowClear: true
  ajax:
    url: window.location.origin + "/#{opts.resourcesPath}.json/"
    dataType: 'json'
    data: (term, page) ->
      object =
        page: page
        order: opts.order

      object[opts.queryKey] = term
      object
    results: (data, page) ->
      results: data
  initSelection: (element, callback) ->
    resource_id = $(element).val()
    $.ajax
      url: window.location.origin + opts.resourcesPath + "/#{resource_id}.json/",
      dataType: "json"
    .done (data) ->
      callback data
  formatResult: (data) ->
    "<div class='select2-user-result'>" + resultFormat(data) + "</div>";
  formatSelection: (data) ->
    resultFormat(data)

$ ->
  $('.select2-filter').parent().find('select').hide()
  $('.select2-filter, .select2-field').each (i, e) ->
    options = select2Options $(e).data().select2Options
    $(e).select2 options

$ ->
  $('#maintenance_ticket_assigned_to').select2
    width: '400px'
