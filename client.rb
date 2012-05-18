#!/usr/bin/env ruby

# A client subscribes to the aggregator server and receives the messages

require 'zmq'
require 'json'

server_host = "picus.vpn.leukensis.org"
server_port = "42390"
server = "tcp://#{server_host}:#{server_port}"

context = ZMQ::Context.new(1)
receiver = context.socket(ZMQ::SUB)
receiver.connect(server)
receiver.setsockopt ZMQ::SUBSCRIBE, ""

trap("INT") { receiver.setsockopt ZMQ::LINGER, 100; receiver.close; context.close; p "Shutting down.."; exit }

while true do
    data = receiver.recv(ZMQ::NOBLOCK)
    if data != nil then
        msg = JSON.parse(data)
        p "Facility: #{msg['facility']}, Type: #{msg['type']}, Priority: #{msg['priority']}, Content: #{msg['content'].length}"
    else
        sleep 0.001
    end
end
