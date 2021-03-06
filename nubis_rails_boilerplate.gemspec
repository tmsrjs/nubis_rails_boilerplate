# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name              = 'nubis_rails_boilerplate'
  s.version           = '0.1.0'
  s.date              = '2013-05-29'
  s.summary           = 'My preferred rails application templates, capistrano tasks, etc'
  s.description       = 'I usually start the same rails apps, running on the same infrastructure, so this collection of recipes and application templates let me focus on what I care about the most.'
  s.authors           = ["Nubis"]
  s.email             = 'yo@nubis.im'
  s.files             = Dir["skeletons/**/*"] + Dir["lib/**/*"] + ["Readme.md", "MIT-LICENSE"]
  s.homepage          = "https://github.com/nubis/nubis_rails_boilerplate"
  s.bindir            = 'bin'
  s.executables       = (`git ls-files -- bin/*`).split("\n").map{ |f| File.basename(f) }

  s.add_dependency('capistrano')
  s.add_dependency('activeadmin', '0.6.0')
  s.add_dependency('settingslogic')
  s.add_dependency('rails', '~> 3.2.0')
end
