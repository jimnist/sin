require 'rake/testtask'

task :default => [:test]

desc "Run all tests"
task :test do
  test_task = Rake::TestTask.new("alltests") do |t|
    t.test_files = Dir.glob(File.join("test", "**", "*_test.rb"))
  end
  task("alltests").execute
end