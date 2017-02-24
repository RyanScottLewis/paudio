require 'spec_helper'

describe PAudio::SinkListParser do

  describe '#parse' do

    let(:fixture) { RSpec.root.join('fixtures', 'pactl_list_sinks.txt').read }
    let(:result) { subject.parse(fixture).collect(&:to_h) }

    it 'should parse correctly' do
      expect(result).to eq([
        {
          id: 0,
          state: 'RUNNING',
          name: 'alsa_output.pci-0000_00_1b.0.analog-stereo',
          description: 'Built-in Audio Analog Stereo',
          channel_map: ['front-left', 'front-right'],
          mute: false,
          volume: [
            {
              name: 'front-left',
              value: 58964,
              percent: 90,
              decibels: -2.75
            },
            {
              name: 'front-right',
              value: 58964,
              percent: 90,
              decibels: -2.75
            }
          ],
          balance: 0.0,
          base_volume: {
            name: nil,
            value: 65536,
            percent: 100,
            decibels: 0.0
          },
          latency: '20079 usec, configured 23220 usec',
          flags: %w[HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY],
          ports: [
            {
              name: 'analog-output-speaker',
              description: 'Speakers',
              priority: 10000,
              available: false
            },
            {
              name: 'analog-output-headphones',
              description: 'Headphones',
              priority: 9000,
              available: true
            }
          ],
          active_port: 'analog-output-headphones',
          formats: %w[pcm]
        }
      ])
    end

  end

end
