class CalibrationProperty < EnumerateIt::Base
  associate_values(
    :hcho => [0, N_('Formaldehyde')],
    :co2 => [1, N_('CO2')],
    :tvoc => [2, N_('TVOC')],
    :pm2p5 => [3, N_('PM 2.5')]

  )
end
