require 'paudio/sink'
require 'paudio/port'

module PAudio
  class SinkListParser

    CHUNK_REGEX = /.*#([^\n]*)\n.*State: ([^\n]*)\n.*Name: ([^\n]*)\n.*Description: ([^\n]*)\n.*Channel Map: ([^\n]*)\n.*Mute: ([^\n]*)\n.*Volume: ([^\n]*)\n.*balance ([^\n]*)\n.*Base Volume: ([^\n]*)\n.*Latency: ([^\n]*)\n.*Flags: ([^\n]*)\n.*Ports:(?!Active Ports)(.*)Active Port: ([^\n]*)\n.*Formats:\n(.*)/m

    # Parse the output of the `pactl list sinks` command
    def parse(data)
      data.split('Sink ').collect do |chunk|
        next if chunk.empty?

        match      = chunk.match(CHUNK_REGEX)
        keys       = %i[id state name description channel_map mute volume balance base_volume latency flags ports active_port formats]
        values     = match[1..14]
        attributes = convert_attributes(keys, values)

        Sink.new(attributes)
      end.compact
    end

    # List all sinks
    def list
      parse(`pactl list sinks`)
    end

    protected

    def parse_channel_map(value)
      value.split(',').collect(&:strip)
    end

    def parse_mute(value)
      return value if value.is_a?(TrueClass) || value.is_a?(FalseClass)

      value = value.to_s.strip.downcase
      value == "yes"
    end

    def parse_volume(value) # TODO: Very similar to parse_ports
      value.to_s.split(',').collect do |chunk|
        match = chunk.match(/([^:]+):(.+)/)
        name  = match[1].strip
        data  = match[2].strip

        convert_volume(name, data)
      end
    end

    def parse_flags(value)
      value.split
    end

    def parse_ports(value) # TODO: Very similar to parse_volume
      value.strip.lines.collect do |line|
        match = line.match(/([^:]+):(.+)/)
        name  = match[1].strip
        data  = match[2].strip

        convert_port(name, data)
      end
    end

    def parse_formats(value)
      value.strip.lines.collect(&:strip)
    end

    def convert_volume(name, value)
      split = value.to_s.split('/')

      Volume.new(name: name, value: split[0], percent: split[1], decibels: split[2])
    end

    def convert_port(name, value)
      match = value.match(/^(\w+) \(priority: (\d+), (.+)\)/)

      description = match[1].strip
      priority    = match[2].to_i
      available   = match[3] == 'available'

      Port.new(name: name, description: description, priority: priority, available: available)
    end

    def convert_attributes(keys, values)
      attributes = Hash[keys.zip(values)]

      attributes[:channel_map] = parse_channel_map(attributes[:channel_map])
      attributes[:mute]        = parse_mute(attributes[:mute])
      attributes[:volume]      = parse_volume(attributes[:volume])
      attributes[:base_volume] = convert_volume(nil, attributes[:base_volume])
      attributes[:flags]       = parse_flags(attributes[:flags])
      attributes[:ports]       = parse_ports(attributes[:ports])
      attributes[:formats]     = parse_formats(attributes[:formats])

      attributes
    end

  end
end
