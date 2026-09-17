#!/usr/bin/env ruby
# frozen_string_literal: true

# Regenerates the package tables in README.md from the formulae and casks in
# this tap. Run with --check to fail instead of writing (used by CI on PRs).

require "optparse"

ROOT = File.expand_path("..", __dir__)
README = File.join(ROOT, "README.md")
TAP = "r0adkll/tap"

START_MARKER = "<!-- BEGIN PACKAGES -->"
END_MARKER = "<!-- END PACKAGES -->"

Package = Struct.new(:token, :name, :desc, :homepage, :version, :kind) do
  def install_command
    kind == :cask ? "brew install --cask #{TAP}/#{token}" : "brew install #{TAP}/#{token}"
  end
end

def field(source, key)
  source[/^\s*#{key}\s+"([^"]*)"/, 1]
end

# "class DangerKotlin < Formula" / "cask \"clinic\" do" both name the package,
# but the filename is what `brew install` actually takes.
def parse(path, kind)
  source = File.read(path)
  token = File.basename(path, ".rb")
  Package.new(
    token,
    field(source, "name") || token,
    field(source, "desc"),
    field(source, "homepage"),
    field(source, "version"),
    kind,
  )
end

def collect
  formulae = Dir[File.join(ROOT, "Formula", "*.rb"), File.join(ROOT, "*.rb")]
  casks = Dir[File.join(ROOT, "Casks", "*.rb")]
  [
    formulae.map { |path| parse(path, :formula) }.sort_by(&:token),
    casks.map { |path| parse(path, :cask) }.sort_by(&:token),
  ]
end

def table(packages)
  rows = packages.map do |pkg|
    name = pkg.homepage ? "[#{pkg.token}](#{pkg.homepage})" : pkg.token
    "| #{name} | #{pkg.desc} | #{pkg.version || "—"} | `#{pkg.install_command}` |"
  end
  ([
    "| Package | Description | Version | Install |",
    "| --- | --- | --- | --- |",
  ] + rows).join("\n")
end

def section
  formulae, casks = collect
  parts = []
  unless formulae.empty?
    parts << "### Formulae\n\n#{table(formulae)}"
  end
  unless casks.empty?
    parts << "### Casks\n\n#{table(casks)}"
  end
  parts.join("\n\n")
end

def render(readme)
  body = "#{START_MARKER}\n\n#{section}\n\n#{END_MARKER}"
  if readme.include?(START_MARKER) && readme.include?(END_MARKER)
    readme.sub(/#{Regexp.escape(START_MARKER)}.*?#{Regexp.escape(END_MARKER)}/m, body)
  else
    "#{readme.rstrip}\n\n#{body}\n"
  end
end

check_only = false
OptionParser.new do |opts|
  opts.banner = "Usage: scripts/update-readme.rb [--check]"
  opts.on("--check", "Exit non-zero if README.md is out of date") { check_only = true }
end.parse!

current = File.read(README)
updated = render(current)

if current == updated
  puts "README.md is up to date."
  exit 0
end

if check_only
  warn "README.md is out of date. Run scripts/update-readme.rb and commit the result."
  exit 1
end

File.write(README, updated)
puts "README.md updated."
