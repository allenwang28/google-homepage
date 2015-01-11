require 'socket'
require 'json'

host = 'localhost'
port = 2000

input = ""
params = {}
params[:viking] = {}

until input == "get" or input == "post"
  puts "Which request would you like to make? POST or GET?"
  input = gets.chomp.downcase
end

if input == "get"
  request = "GET /index.html HTTP/1.0\r\n\r\n"
else
  puts "Enter a name:"
  params[:viking][:name] = gets.chomp
  puts "Enter an email:" 
  params[:viking][:email] = gets.chomp
  form = params.to_json
  request = "POST /thanks.html HTTP/1.0\r\nContent-Length: #{params.to_json.size}\r\n\r\n#{form}"
end

socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
puts response
headers,body = response.split("\r\n\r\n", 2)
if headers.split[1] == '200'
  print body
elsif headers.split[1] == '404'
  print "404 error: #{body}"
end
