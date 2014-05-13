# coding: utf-8
load "Server.rb"
load "MultiThread.rb"

def r; load "Main.rb" end

extend Server
extend MultiThread

# --------------------------------------------------



# --------------------------------------------------

@@handlers = Array.new #--------------------

def acceptLoopPerUser(handler)
  line = hGetLine(handler)
  puts (peerAddr handler) + " : " + line
  #-------------------- start
  @@handlers.each do |h|
    if ((peerAddr h) != (peerAddr handler))
      hPutStrLn(h, (peerAddr handler) + " : " + line)
    end
  end
  #-------------------- end
  #hPutStrLn(handler, line.reverse)
  acceptLoopPerUser(handler)
end

def acceptLoop(server)
  handler = mkHandler(server)
  @@handlers.push(handler) #--------------------
  puts "Access from " + peerAddr(handler)
  acceptloopps = ->(handler) {
    ->() {
      acceptLoopPerUser(handler)
    }
  }
  forkIO(acceptloopps.(handler))
  acceptLoop(server)
end

def main
  bracketOnErrorDebug(
    ->() {
      mkServer(8080)
    },->(server) {
      closeServer(server)
    },->(server) {
      acceptLoop(server)
      closeServer(server)
    })
end

# --------------------------------------------------
