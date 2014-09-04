@AirAware = {}
@AirAware.Models = {}
@AirAware.Collections = {}
@AirAware.Views = {}

@AirAware.ie = () ->
  target = $("meta[name='ie-version']")
  if target
    return parseInt(target.attr("content"))
  else
    return null

@AirAware.locale = ()->
  if location.pathname.substring(0,3) == "/zh" then 'zh' else 'en'

@AirAware.humanizeRating = (rating) ->
  return __("Hazardous") if rating == "hazardous"
  return __("Very Unhealthy") if rating == "very-unhealthy"
  return __("Unhealthy") if rating == "unhealthy"
  return __("Sensitive") if rating == "sensitive"
  return __("Moderate") if rating == "moderate"
  return __("Good") if rating == "good"
  __("Unknown")

@AirAware.assessAirClass = (reading) ->
  value = parseInt(reading)
  return unless value > 0
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
  return unless value > 0
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
  return unless value > 0
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

@AirAware.assessHchoClass = (reading) ->
  value = parseFloat(reading)
  return unless value > 0
  if value < 0.072
    return "good"
  else if value < 0.088
    return "moderate"
  else
    return "unhealthy"

@AirAware.assessTvocClass = (reading) ->
  value = parseFloat(reading)
  return unless value > 0
  if value < 0.45
    return "good"
  else if value < 0.55
    return "moderate"
  else
    return "unhealthy"

@AirAware.UTCTime = (datetime, options) ->
  with_tzone = datetime.replace(/Z/,"+08:00")
  a = Date.fromISO(with_tzone)
  if isNaN(a)
    a = new Date()
    a.setISO8601(with_tzone)
  a

@AirAware.matchTime = (datetime) ->
  datetime.match(/(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z/)

@AirAware.parseTime = (datetime, options) ->
  defaults = {seconds: true, hours: true, minutes: true}
  options = _.extend defaults, options
  # date = new Date(datetime)
  # hours = date.getUTCHours()
  # minutes = date.getMinutes()
  # seconds = date.getSeconds()
  date = @matchTime(datetime)
  year    = parseInt(date[1])
  month   = parseInt(date[2])
  day     = parseInt(date[3])
  hours   = parseInt(date[4])
  minutes = parseInt(date[5])
  seconds = parseInt(date[6])

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
    return true
