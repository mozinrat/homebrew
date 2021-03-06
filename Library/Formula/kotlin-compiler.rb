class KotlinCompiler < Formula
  desc "Statically typed programming language for the JVM"
  homepage "https://kotlinlang.org/"
  url "https://github.com/JetBrains/kotlin/releases/download/build-0.14.449/kotlin-compiler-0.14.449.zip"
  sha256 "bbb55c84669b6d920dc89beab811b26dfbdbeb95d71e1d6d3384fbfbcd48ec70"

  devel do
    url "https://github.com/JetBrains/kotlin/releases/download/build-1.0.0-beta-1038/kotlin-compiler-1.0.0-beta-1038.zip"
    version "1.0.0-beta-1038"
    sha256 "53e1516eb95274ac58b5445d1d8a82d265166d7c5038a878395589604f35275c"
  end

  bottle :unneeded

  def install
    libexec.install %w[bin lib]
    rm Dir["#{libexec}/bin/*.bat"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.kt").write <<-EOS.undent
      fun main(args: Array<String>) {
        println("Hello World!")
      }
    EOS
    system "#{bin}/kotlinc", "test.kt", "-include-runtime", "-d", "test.jar"
    system "#{bin}/kotlinc-js", "test.kt", "-output", "test.js"
    system "#{bin}/kotlinc-jvm", "test.kt", "-include-runtime", "-d", "test.jar"
  end
end
