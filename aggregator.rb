#!/usr/bin/env ruby

# This is the core server. It receives all the messages, and
# dispatches them to whoever needs it

require 'zmq'

context = ZMQ::Context.new(1)
receiver = context.socket(ZMQ::PULL)
receiver.bind("tcp://*:42389")
publisher = context.socket(ZMQ::PUB)
publisher.bind("tcp://*:42390")

trap("INT") { publisher.close; receiver.close; context.close; p "Shutting down."; exit }

while true do
    data = receiver.recv(ZMQ::NOBLOCK)
    if data != nil then
    	publisher.send(data)
    	p "Data processed !"
    else
        sleep 0.001
    end
end

