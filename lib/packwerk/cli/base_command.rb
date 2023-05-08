# typed: strict
# frozen_string_literal: true

module Packwerk
  class Cli
    class BaseCommand
      extend T::Sig
      extend T::Helpers
      abstract!

      @description = T.let("", String)

      class << self
        extend T::Sig

        sig { params(description: T.nilable(String)).returns(String) }
        def description(description = nil)
          if description
            @description = description
          else
            @description
          end
        end
      end

      sig do
        params(
          args: T::Array[String],
          configuration: Configuration,
          out: T.any(StringIO, IO),
          err_out: T.any(StringIO, IO),
          progress_formatter: Formatters::ProgressFormatter,
          offenses_formatter: OffensesFormatter,
        ).void
      end
      def initialize(args, configuration:, out:, err_out:, progress_formatter:, offenses_formatter:)
        @args = args
        @configuration = configuration
        @out = out
        @err_out = err_out
        @progress_formatter = progress_formatter
        @offenses_formatter = offenses_formatter
      end

      sig { abstract.returns(T::Boolean) }
      def run; end
    end
  end
end
