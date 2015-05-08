require_relative 'role'

if ARGV.length > 0
  puts File.read(File.dirname(__FILE__) + '/../README.md')
  exit
end

role = Role.new

command = STDIN.gets
while command
  output = role.run(command)
  puts output if output
  target = open('report.txt','w')
  target.write(output)
  target.write("\n")
  target.close
  command = STDIN.gets
end
