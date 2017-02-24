require 'paudio/volume'
require 'paudio/port'
require 'paudio/sink_list_parser'
require 'paudio/has_attributes'

module PAudio

  class Sink

    class << self

      def list
        SinkListParser.new.list
      end

    end

    include HasAttributes

    def initialize(attributes={})
      update_attributes(attributes)
    end

    attr_reader :id

    def id=(value)
      @id = value.to_i
    end

    attr_reader :state

    def state=(value)
      @state = value.to_s
    end

    attr_reader :name

    def name=(value)
      @name = value.to_s
    end

    attr_reader :description

    def description=(value)
      @description = value.to_s
    end

    attr_reader :channel_map

    def channel_map=(value)
      @channel_map = convert_strings(value)
    end

    attr_reader :mute

    def mute=(value)
      @mute = !!value
    end

    attr_reader :volume

    def volume=(value)
      @volume = convert_volume_attribute(value)
    end

    attr_reader :balance

    def balance=(value)
      @balance = value.to_f
    end

    attr_reader :base_volume

    def base_volume=(value)
      @base_volume = convert_volume(value)
    end

    attr_reader :latency

    def latency=(value)
      @latency = value.to_s
    end

    attr_reader :flags

    def flags=(value)
      @flags = convert_strings(value)
    end

    attr_reader :ports

    def ports=(value)
      @ports = convert_ports_attribute(value)
    end

    attr_reader :active_port

    def active_port=(value)
      @active_port = value.to_s
    end

    attr_reader :formats

    def formats=(value)
      @formats = convert_strings(value)
    end

    def raise_volume(percentage)
      system("pactl set-sink-volume #{@id} +#{percentage}%")
    end

    def lower_volume(percentage)
      system("pactl set-sink-volume #{@id} -#{percentage}%")
    end

    def set_mute(value)
      value = !!value ? 1 : 0

      system("pactl set-sink-mute #{@id} #{value}")
    end

    def toggle_mute
      system("pactl set-sink-mute #{@id} toggle")
    end

    def to_h
      volume      = @volume.collect(&:to_h)
      base_volume = @base_volume.to_h
      ports       = @ports.collect(&:to_h)

      {
        id:          @id,
        state:       @state,
        name:        @name,
        description: @description,
        channel_map: @channel_map,
        mute:        @mute,
        volume:      volume,
        balance:     @balance,
        base_volume: base_volume,
        latency:     @latency,
        flags:       @flags,
        ports:       ports,
        active_port: @active_port,
        formats:     @formats
      }
    end

    protected

    def convert_strings(value)
      value.to_a.collect(&:to_s)
    end

    def convert_volume(value)
      value.is_a?(Volume) ? value : Volume.new(value)
    end

    def convert_volume_attribute(value)
      value.to_a.collect { |value| convert_volume(value) }
    end

    def convert_port(value)
      value.is_a?(Port) ? value : Port.new(value)
    end

    def convert_ports_attribute(value)
      value.to_a.collect { |value| convert_port(value) }
    end

  end

end
