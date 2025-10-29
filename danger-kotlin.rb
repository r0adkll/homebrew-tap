class DangerKotlin < Formula
  desc "Write your Dangerfiles in Kotlin"
  homepage "https://github.com/r0adkll/danger-kotlin"
  version "2.1.0"
  head "https://github.com/r0adkll/danger-kotlin.git"
  
  if Hardware::CPU.arm?
    url "https://github.com/r0adkll/danger-kotlin/releases/download/#{version}/danger-kotlin-macosArm64.tar"
    sha256 "795702ce82ec39fff9fbca580eb25564fb03a0c4f298a804db2d53c854820fcc"
  
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
    sha256 "a33c2193371fe2dbdd6ad17791493ea7cf820a3436802dc3963809b7c640dd2d"

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
