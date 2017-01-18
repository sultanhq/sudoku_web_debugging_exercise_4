require 'rake/testtask'
require 'rake'
require 'ci/reporter/rake/minitest'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.test_files = FileList['test/*_test.rb']
end

desc 'Verifies that the code has been correctly debugged by running a clean version of the tests'
Rake::TestTask.new(:verify) do |t|
  t.libs = ["lib"]
  t.test_files = FileList['.spec_verify/*_test.rb']
end

task :default => [:test]

task :ci => ['ci:setup:minitest', 'test']
