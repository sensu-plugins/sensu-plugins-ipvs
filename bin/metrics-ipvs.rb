#!/usr/bin/env ruby
require 'sensu-plugin/metric/cli'
require 'socket'

class Graphite < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
 	 description: 'Metric naming scheme, text to prepend to metric',
     	 short: '-s SCHEME',
     	 long: '--scheme SCHEME',
     	 default: "#{Socket.gethostbyname("#{Socket.gethostname}").first}.ipvs.stats"

  def run
    ipvs = metrics_hash
    metrics = [ "TotalConn", "IncomingPkts", "OutgoingPkts", "IncomingBytes", "OutgoingBytes", "Conns_per_sec", "Pkts_per_sec", "IncomingBytes_per_sec", "OutgoingBytes_per_sec" ]
    c = 0
    metrics.each do |parent|
      output [config[:scheme], parent].join("."), ipvs[c].hex
      c += 1
    end
    ok
  end

  def metrics_hash
    ipvs = []
    `cat /proc/net/ip_vs_stats | egrep -v "Total|Conns"`.each_line do |line|
      line.chomp!
      next if line.empty? || !(line.split & ipvs).empty?
      ipvs.push(line.gsub(/\s+/, " ").rstrip.split(" "))
    end
    ipvs.join(".").split(".")
  end
end
