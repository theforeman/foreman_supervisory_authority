# frozen_string_literal: true

require 'rake/testtask'

# Tests
namespace :test do
  desc 'Test ForemanSupervisoryAuthority'
  Rake::TestTask.new(:foreman_supervisory_authority) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_supervisory_authority do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_supervisory_authority) do |task|
        task.patterns = ["#{ForemanSupervisoryAuthority::Engine.root}/app/**/*.rb",
                         "#{ForemanSupervisoryAuthority::Engine.root}/lib/**/*.rb",
                         "#{ForemanSupervisoryAuthority::Engine.root}/test/**/*.rb"]
      end
    rescue StandardError
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_supervisory_authority'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_supervisory_authority']

load 'tasks/jenkins.rake'
Rake::Task['jenkins:unit'].enhance ['test:foreman_supervisory_authority', 'foreman_supervisory_authority:rubocop'] if Rake::Task.task_defined?(:'jenkins:unit')
