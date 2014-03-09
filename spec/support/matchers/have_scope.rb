RSpec::Matchers.define :have_scope do |scope_name, *args|
  match do |actual|
    actual = actual.class unless actual.is_a? Class
    actual.send(scope_name, *args)
    true
  end

  failure_message_for_should do |actual|
    "Expected relation to have scope #{scope_name} #{args.present? ? "with args #{args.inspect}" : ""} but it didn't " + actual
  end

  failure_message_for_should_not do |actual|
    "Expected relation not to have scope #{scope_name} #{args.present? ? "with args #{args.inspect}" : ""} but it didn't " + actual
  end

  description do
    "have scope #{scope_name} #{args.present? ? "with args #{args.inspect}" : ""}"
  end
end
