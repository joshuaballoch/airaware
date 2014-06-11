class LocationUserRole < EnumerateIt::Base
  associate_values(
    :admin => [1, N_('Admin')],
    :member =>[0, N_('Member')]
  )
end
