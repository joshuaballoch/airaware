class ReportingDeviceType < EnumerateIt::Base
  associate_values(
    :fluke => [0, N_('Fluke')],
    :air_advice =>[1, N_('AirAdvice')]
  )
end
