desc "deploy to heroku and notify hoptoad"
task :deploy => :environment do
  puts "deploying to heroku..."
  %x[git push heroku master]
  puts "notifying hoptoad..."
  rev = %x[git log master -n 1 --pretty=format:%H]
  %x[rake hoptoad:deploy TO=production REVISION=#{rev}]
  puts "done..."
end
