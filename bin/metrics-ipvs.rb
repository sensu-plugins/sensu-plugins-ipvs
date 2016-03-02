#!/usr/bin/env ruby
#
#  metrics-ipvs
#
# DESCRIPTION:
#   This plugin get metrics for ipvs
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   metrics-ipvs
#
# NOTES:
#
# LICENSE:
#   Marc-Andre Gatien    <https://github.com/mag009>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#
require 'sensu-plugin/metric/cli'
require 'socket'

#
#
#
class Graphite < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostbyname(Socket.gethostname.to_s).first}.ipvs.stats"

  def run
    unless ipvs_output.nil?
      ipvs = metrics_hash(ipvs_output)
      metrics = %w(TotalConn
                   IncomingPkts
                   OutgoingPkts
                   IncomingBytes
                   OutgoingBytes
                   Conns_per_sec
                   Pkts_per_sec
                   IncomingBytes_per_sec
                   OutgoingBytes_per_sec)
      c = 0
      metrics.each do |parent|
        output [config[:scheme], parent].join('.'), ipvs[c].hex
        c += 1
      end
    end
    ok
  end

  def metrics_hash(output)
    ipvs = []
    output.each_line do |line|
      line.chomp!
      next if line.empty? || !(line.split & ipvs).empty?
      ipvs.push(line.gsub(/\s+/, ' ').rstrip.split(' '))
    end
    ipvs.join('.').split('.')
  end

  def ipvs_output
    return `cat /proc/net/ip_vs_stats | egrep -v "Total|Conns"` if File.exist?('/proc/net/ip_vs_stats')
  end
end
