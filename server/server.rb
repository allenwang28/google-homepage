require 'socket'
require 'json'

server = TCPServer.open(2000)
loop {
  Thread.start(server.accept) do |client|
    puts "hello client"
    request = client.read_nonblock(256)
    header,body = request.split("\r\n\r\n", 2)
    path = header.split[1][1..-1]
    method = header.split[0]
    puts request

    if File.exists?(path)
      puts "File found"
      file = File.read(path)
      client.puts("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n")
      if method == "GET"
        puts "GET request!"
        request = "Content-Length: #{file.size.to_s}\r\n\r\n#{file}"
        client.puts(request)
      elsif method == "POST"
        puts "POST request!" 
        params = JSON.parse(body) 
        puts params
        request = file.to_s.gsub("<%= yield %>", "Name: #{params['viking']['name']}, Email: #{params['viking']['email']}") 
        puts request
        client.puts(request)
      end

      client.puts "Closing the connection. Bye!"
      client.close
    else
      print "File not found"
      request = "HTTP/1.0 404\r\n\r\n File not found" 
      client.puts(request)
      client.close
    end


  end
}
