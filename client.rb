#!/usr/bin/env ruby

# A client subscribes to the aggregator server and receives the messages

require 'zmq'
require 'json'

context = ZMQ::Context.new(1)
receiver = context.socket(ZMQ::SUB)
receiver.connect("tcp://localhost:42390")
receiver.setsockopt ZMQ::SUBSCRIBE, ""

trap("INT") { receiver.close; context.close; p "Shutting down.."; exit }

while true do
    data = receiver.recv
    p data
end
