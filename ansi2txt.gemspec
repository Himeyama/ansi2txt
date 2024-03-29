# frozen_string_literal: true

require_relative "lib/ansi2txt/version"

Gem::Specification.new do |spec|
  spec.name = "ansi2txt"
  spec.version = Ansi2txt::VERSION
  spec.authors = ["HIKARI"]
  spec.email = ["hikari.photon+dev@gmail.com"]

  spec.summary = "ansi2txt converts ANSI escape sequences to readable plain text."
  spec.description = "ansi2txt converts ANSI escape sequences to readable plain text."
  spec.homepage = "https://github.com/Himeyama/ansi2txt"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
