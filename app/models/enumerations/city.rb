class City < EnumerateIt::Base
  associate_values(
    :beijing => [1, N_('Beijing')],
    :shanghai =>[0, N_('Shanghai')]
  )
end
