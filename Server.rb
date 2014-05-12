require "socket"

module Server

  @@module_function = [
    :mkServer,
    :closeServer,
    :hGetLine,
    :mkHandler,
    :hPutStrLn,
    :bracketOnError,
    :bracketOnErrorDebug,
    :peerAddr
  ]

  # --------------------------------------------------
  
  # --------------------------------------------------
  
  def mkServer(port)
    TCPServer.open(port)
  end

  def closeServer(server)
    server.close
  end

  def mkHandler(server)
    server.accept
  end

  def hGetLine(handler)
    handler.gets
  end

  def hPutStrLn(handler, str)
    handler.puts str
  end

  def bracketOnError(start, error, default)
    result = start.call
    begin
      default.call(result)
    rescue
      error.call(result)
    end
  end

  def bracketOnErrorDebug(start, error, default)
    result = start.call
    begin
      default.call(result)
    rescue => err
      puts err
      error.call(result)
    end
  end

  def peerAddr(handler)
    handler.peeraddr[2]
  end

  @@module_function.each do | fn |
    module_function fn
  end
  
end
