class DangerKotlin < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.0.3"
  url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosArm64.tar"
  sha256 "5dcfde55ed3f2b1a0fbfe71ee220ee6e77235059b8a4f9fbda42eaae46023efd"
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
