# Shamelessly taken from http://mislav.uniqpath.com/2010/09/cuking-it-right/
{
  'in the title' => 'h2',
  'in the type description' => 'h3',
  'in the page body' => '.inner p',
  'in a button' => 'button, input[type=submit]',
  'in the navigation' => '#main-navigation',
  'in the notice flash' => '.flash .notice',
  'in the error flash' => '.flash .error',
  'in the warning flash' => '.flash .warning'
}.
each do |within, selector|
  Then /^(.+) #{within}$/ do |step|
    with_scope(selector) do
      Then step
    end
  end
end
