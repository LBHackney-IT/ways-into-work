require 'coderay'
require 'byebug'

module DebugStepHelper
  # use this when in an actual debugging session
  def peek
    output = CodeRay.scan(page.body, :html).term
    print '-- peeking at body'
    print output
    print '-- end peeking at body'
  end

  # use this in step definitions
  def peek_body
    output = CodeRay.scan(page.body, :html).term
    print '-- peeking at body'
    print output
    print '-- end peeking at body'
  end
end
World(DebugStepHelper)

Then 'peek body' do
  peek_body
end

Then /^pending (.+)/ do |msg|
  pending msg
end

Then "debug" do
  debugger
  1
end

