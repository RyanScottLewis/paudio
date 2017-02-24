module PAudio
  module Formatter

    class Base
      def initialize(sink)
        @sink = sink
      end

      def to_s
        @sink.to_s
      end
    end

  end
end
