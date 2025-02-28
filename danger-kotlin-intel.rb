class DangerKotlin < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.0.1"
  url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosX64.tar"
  sha256 "8f8a29204cbb3fb78776f8b48891a38e59ef78525887311195ea9d80993fd59f"
  head "https://github.com/r0adkll/danger-kotlin.git"

  # Use the vendored danger
  depends_on "danger/tap/danger-js"
  depends_on "kotlin"

 def install
    libexec.install %w[bin]
    prefix.install %w[lib]
    (bin/"danger-kotlin").write_env_script libexec/"bin/danger-kotlin", Language::Java.overridable_java_home_env
 end
end
