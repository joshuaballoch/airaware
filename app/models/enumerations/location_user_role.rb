class LocationUserRole < EnumerateIt::Base
  # see http://en.wikipedia.org/wiki/ISO_4217
  associate_values(
    :admin => [1, N_('Admin')],
    :member =>[0, N_('Member')]
  )
end
