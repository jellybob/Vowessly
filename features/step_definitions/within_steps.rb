# Shamelessly taken from http://mislav.uniqpath.com/2010/09/cuking-it-right/
{
  'in the title' => 'h2',
  'in a button' => 'button, input[type=submit]',
  'in the navigation' => '#main-navigation'
}.
each do |within, selector|
  Then /^(.+) #{within}$/ do |step|
    with_scope(selector) do
      Then step
    end
  end
end
