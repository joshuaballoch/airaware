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
