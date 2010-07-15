#
# 'autotest' for riot
# install watchr
# $ sudo gem install watchr
# 
# Run With:
# $ watchr test.watchr
#

# --------------------------------------------------
# Helpers
# --------------------------------------------------

def run(cmd)
  puts(cmd)
  system(cmd)
end

def run_all_tests
  system( "padrino rake test" )
end

def sudo(cmd)
  run("sudo #{cmd}")
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch("^lib.*/(.*)\.rb") { |m| run("ruby test/#{m[1]}_test.rb") }
watch("^app/controllers/(.*).rb") { |m| run("ruby test/controllers/#{m[1]}_controller_test.rb")}
watch("^test/controllers/(.*)_test.rb") { |m| run("ruby test/controllers/#{m[1]}_test.rb")}
watch("^app/models/(.*).rb") { |m| run("ruby test/models/#{m[1]}_test.rb")}
watch("^test/models/(.*)_test.rb") { |m| run("ruby test/models/#{m[1]}_test.rb")}
watch("test.*/test_config\.rb") { run_all_tests }
watch("^test/(.*)_test\.rb")  { |m| run("ruby test/#{m[1]}_test.rb")}

watch("^app/views/(.*)/(.*).haml") { |m| run("ruby test/controllers/#{m[1]}_controller_test.rb")}

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end
 
# Ctrl-C
Signal.trap('INT') { abort("\n") }