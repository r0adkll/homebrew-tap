class DangerKotlin < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.0.5"
  url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosArm64.tar"
  sha256 "d328fc82e893d3210844a85cd3b1095993e6e9e248d65e1666942a3327822ee3"
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
