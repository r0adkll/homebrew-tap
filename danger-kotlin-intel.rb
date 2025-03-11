class DangerKotlinIntel < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.0.5"
  url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosX64.tar"
  sha256 "1bbe5c0a6dc871c1d3a453b6b1cd382d378b466594e08927fb649a0449cff574"
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
