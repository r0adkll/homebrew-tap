class DangerKotlin < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.0.7"
  head "https://github.com/r0adkll/danger-kotlin.git"
  
  if Hardware::CPU.arm?
    url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosArm64.tar"
    sha256 "869d676a9b62efeac47e6b42f4da634d1d39807be9d15ae76a4fde0e60d67ae0"
  
    # Use the vendored danger
    depends_on "danger/tap/danger-js"
    depends_on "kotlin"

    def install
      libexec.install %w[bin]
      prefix.install %w[lib]
      (bin/"danger-kotlin").write_env_script libexec/"bin/danger-kotlin", Language::Java.overridable_java_home_env
    end
  end

  if Hardware::CPU.intel?
    url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosX64.tar"
    sha256 "d8011232835d2fe09a848c0439a63a54d8ccc619d0aab42361844863eceeb068"

    # Use the vendored danger
    depends_on "danger/tap/danger-js"
    depends_on "kotlin"

    def install
      libexec.install %w[bin]
      prefix.install %w[lib]
      (bin/"danger-kotlin").write_env_script libexec/"bin/danger-kotlin", Language::Java.overridable_java_home_env
    end
  end
end
