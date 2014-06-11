class PrivacyEnumeration < EnumerateIt::Base
  associate_values(
    :public => [0, N_('Public')],
    :private =>[1, N_('Private')]
  )
end
