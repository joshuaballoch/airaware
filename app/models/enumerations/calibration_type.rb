class CalibrationType < EnumerateIt::Base
  associate_values(
    :linear => [0, N_('Linear (y=ax+b)')]
  )
end
