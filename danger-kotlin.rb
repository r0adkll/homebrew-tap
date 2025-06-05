class DangerKotlin < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.0.8"
  head "https://github.com/r0adkll/danger-kotlin.git"
  
  if Hardware::CPU.arm?
    url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosArm64.tar"
    sha256 "e2fb770555f07293e1edc432c063e99f711826b31bc930ce6b7df6d1b4a1f215"
  
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
    sha256 "7257fe8c4087494b30c5dc59547c5312ccbae07d4c84d04f8a30c813f5a1b3a9"

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
