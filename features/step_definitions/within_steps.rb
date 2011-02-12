# Shamelessly taken from http://mislav.uniqpath.com/2010/09/cuking-it-right/
{
  'in the title' => 'h2',
  'in the type description' => 'h2 .highlighted-title-info-grey',
  'in the page body' => '.inner p',
  'in a button' => 'button, input[type=submit]',
  'in the navigation' => '#main-navigation',
  'in the notice flash' => '.flash .notice',
  'in the error flash' => '.flash .error',
  'in the warning flash' => '.flash .warning',
  'as a search result title' => '.result h3',
  'as a search result type' => '.result h3 .highlighted-title-info-grey'
}.
each do |within, selector|
  Then /^(.+) #{within}$/ do |step|
    with_scope(selector) do
      Then step
    end
  end
end
