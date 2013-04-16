# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "comma-heaven"
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Silvano Stralla"]
  s.date = "2013-04-16"
  s.description = "CommaHeaven permits easy exports of Rails models to CSV"
  s.email = "silvano.stralla@sistrall.it"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "comma-heaven.gemspec",
    "init.rb",
    "lib/comma-heaven.rb",
    "lib/comma-heaven/active_record/to_comma_heaven.rb",
    "lib/comma-heaven/export.rb",
    "lib/comma-heaven/sqler.rb",
    "lib/comma-heaven/sqler/association_columns.rb",
    "lib/comma-heaven/sqler/belongs_to_columns.rb",
    "lib/comma-heaven/sqler/column.rb",
    "lib/comma-heaven/sqler/columns.rb",
    "lib/comma-heaven/sqler/has_many_columns.rb",
    "lib/comma-heaven/sqler/has_one_columns.rb",
    "spec/active_record/to_comma_heaven_spec.rb",
    "spec/export_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/sqler/belongs_to_association_spec.rb",
    "spec/sqler/column_spec.rb",
    "spec/sqler/columns_spec.rb",
    "spec/sqler/has_many_columns_spec.rb",
    "spec/sqler/has_one_association_spec.rb"
  ]
  s.homepage = "http://github.com/sistrall/comma-heaven"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "CSV exporter for Rails"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["< 4.0.0"])
      s.add_runtime_dependency(%q<actionpack>, ["< 4.0.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<mysql2>, ["= 0.2.7"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["< 4.0.0"])
      s.add_dependency(%q<actionpack>, ["< 4.0.0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<mysql2>, ["= 0.2.7"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["< 4.0.0"])
    s.add_dependency(%q<actionpack>, ["< 4.0.0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<mysql2>, ["= 0.2.7"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
  end
end

