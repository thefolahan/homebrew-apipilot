class Apipilot < Formula
  desc "Validate, test, mock and document an API from its OpenAPI spec"
  homepage "https://github.com/thefolahan/api-pilot"
  url "https://github.com/thefolahan/api-pilot/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "af5d18523777babf15e800c1656d64e1d46ac490d3b9bc81a3f25ca4fc1e0963"
  license "MIT"
  head "https://github.com/thefolahan/api-pilot.git", branch: "main"

  depends_on macos: :sonoma

  uses_from_macos "swift" => :build

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "apipilot"
    bin.install ".build/release/apipilot"
  end

  test do
    (testpath/"openapi.yaml").write <<~YAML
      openapi: 3.1.0
      info:
        title: Pets
        version: "1.0"
      paths:
        /pets/{id}:
          get:
            operationId: getPet
            responses:
              "200":
                description: A pet
    YAML

    assert_match version.to_s, shell_output("#{bin}/apipilot --version")
    output = shell_output("#{bin}/apipilot validate #{testpath}/openapi.yaml", 1)
    assert_match "path parameter \"id\" is not declared", output
    assert_match "<title>Pets API reference</title>", shell_output("#{bin}/apipilot docs #{testpath}")
  end
end
