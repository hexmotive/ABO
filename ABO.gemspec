# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ABO}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josef \305\240im\303\241nek"]
  s.date = %q{2010-03-17}
  s.description = %q{RUBY ABO banking format library}
  s.email = %q{retro@ballgag.cz}
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc", "lib/abo.rb"]
  s.files = ["ABO.gemspec", "CHANGELOG", "Manifest", "README.rdoc", "Rakefile", "init.rb", "lib/abo.rb"]
  s.homepage = %q{http://github.com/hexmotive/ABO}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "ABO", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{abo}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{RUBY ABO banking format library}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
