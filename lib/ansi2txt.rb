# frozen_string_literal: true

require_relative "ansi2txt/version"
require "stringio"
require "tempfile"

module Ansi2txt
  class Error < StandardError; end

  # ANSI2TXT converts ANSI escape sequences to readable plain text
  class ANSI2TXT
    def initialize(**kwargs)
      @input = kwargs[:input]
      @input = $stdin if @input.nil?
      @output = kwargs[:output]
      @output = $stdout if @output.nil?
    end

    def getchar
      @input.getc
    end

    def putchar(chara)
      @output.putc(chara)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def ansi2txt
      loop do
        ch = getchar
        while ch.eql?("\r")
          ch = getchar
          putchar("\r") unless ch.eql?("\n")
        end

        if ch.eql?("\e")
          if (ch = getchar).eql?("[")
            while (ch = getchar).eql?(";") || ch.between?("0", "9") || ch.eql?("?")
            end
          elsif ch.eql?("]") && (ch = getchar).between?("0", "9")
            loop do
              if (ch = getchar).nil? || "\a".eql?(ch)
                break
              elsif ch.eql?("\e")
                ch = getchar
                break
              end
            end
          elsif ["%", "(", ")"].include?(ch)
            ch = getchar
          end
        elsif !ch.nil?
          putchar(ch)
        end

        break if ch.nil?
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

    def self.from_io(input)
      output = Tempfile.open("")
      ansi2text = Ansi2txt::ANSI2TXT.new(input: input, output: output)
      ansi2text.ansi2txt
      output.rewind
      result = output.read
      output.close
      result
    end

    attr_reader :input, :output
  end
end
