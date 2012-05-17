#!/usr/bin/env ruby

# This is a procmail notification source. It receives the message on stdin, and should format it in json before sending it over the wire

require 'zmq'
require 'json'

context = ZMQ::Context.new(1)
outbound_socket = context.socket(ZMQ::PUSH)
outbound_socket.connect("tcp://localhost:42389")

msg = STDIN.read()

type = "undecided"

if ARGV.length > 0 then
	type = ARGV[0]
end

json_msg = { :facility => "mail", :type => type, :priority => "weak", :content => msg.to_json }.to_json

outbound_socket.send(json_msg)

outbound_socket.close
context.close
