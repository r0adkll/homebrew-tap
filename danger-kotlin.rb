class DangerKotlin < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.0.1"
  url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosArm64.tar"
  sha256 "92a4576ac9293ebaa1797b4b7214830d346778ed7e613ce0c907f27032cb9367"
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
