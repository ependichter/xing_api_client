class XingApiClient
  module Call
    module Base

    private
      def request_loop(total, result, offset, requested_limit, max_limit_per_call = 100)
        offset ||= 0

        if (requested_limit.nil? || requested_limit.to_i > max_limit_per_call) && total > max_limit_per_call

          local_limit  = requested_limit.nil? ? total : [requested_limit.to_i, total].min
          steps        = (1...(local_limit / max_limit_per_call.to_f).ceil).to_a
          steps.map!{ |s| s * max_limit_per_call + offset }

          yield result, steps

        end
        result.define_singleton_method :total, -> { total }
        result
      end
    end
  end
end
