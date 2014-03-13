@AirAware = {}
@AirAware.Models = {}
@AirAware.Collections = {}
@AirAware.Views = {}


@AirAware.assessAirClass = (reading) ->
  value = parseInt(reading)
  if value < 35
    return "good"
  else if value < 75
    return "moderate"
  else if value < 100
    return "sensitive"
  else if value < 120
    return "unhealthy"
  else if value < 200
    return "very-unhealthy"
  else
    return "hazardous"

@AirAware.assessCo2Class = (reading) ->
  value = parseInt(reading)
  if value < 700
    return "good"
  else if value < 1000
    return "moderate"
  else if value < 1300
    return "sensitive"
  else if value < 1600
    return "unhealthy"
  else if value < 3000
    return "very-unhealthy"
  else
    return "hazardous"

@AirAware.assessHumidityClass = (reading) ->
  value = parseInt(reading)
  if value < 55
    return "good"
  else if value < 65
    return "moderate"
  else if value < 75
    return "sensitive"
  else if value < 85
    return "unhealthy"
  else if value < 90
    return "very-unhealthy"
  else
    return "hazardous"

@AirAware.parseTime = (datetime, options) ->
  defaults = {seconds: true, hours: true, minutes: true}
  options = _.extend defaults, options
  # date = new Date(datetime)
  # hours = date.getUTCHours()
  # minutes = date.getMinutes()
  # seconds = date.getSeconds()
  date = datetime.match(/\d{4}-\d{2}-\d{2}T(\d{2}):(\d{2}):(\d{2})Z/)
  hours = parseInt(date[1])
  minutes = parseInt(date[2])
  seconds = parseInt(date[3])
  hours = if "#{hours}".length < 2 then "0#{hours}" else "#{hours}"
  minutes = if "#{minutes}".length < 2 then "0#{minutes}" else "#{minutes}"
  seconds = if "#{seconds}".length < 2 then "0#{seconds}" else "#{seconds}"
  return "#{hours if options.hours}#{':' if options.hours && (options.minutes || options.seconds)}#{minutes if options.minutes}#{':' if options.minutes && options.seconds}#{seconds if options.seconds}"

@AirAware.precise_round = (num,decimals) ->
  return Math.round(num * Math.pow(10, decimals)) / Math.pow(10, decimals);

$(document).ready () ->
  # Initialize Tooltips
  $(document).on 'mouseenter','[data-toggle="tooltip"], .enable-tooltip', () -> $(this).tooltip({ container: this, animation: false }).triggerHandler('mouseover')
  # Hack to fix tooltips for mobile..
  $(document).on 'click', (e) ->
    $target = $(event.currentTarget)
    unless $target.data('toggle') == "tooltip"
      $('[data-toggle="tooltip"]').trigger('mouseout')
