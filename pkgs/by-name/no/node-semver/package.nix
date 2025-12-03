{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage (finalAttrs: {
  pname = "node-semver";
  version = "7.7.3";

  src = fetchFromGitHub {
    owner = "npm";
    repo = "node-semver";
    rev = "v${finalAttrs.version}";
    hash = "sha256-5kJmCcb8yfo4h4nOSk7c6qsbv7EgbeUMBEJZcfvtmW4=";
  };

  npmDepsHash = "sha256-9ne3DO/5lcpOPiirWZr+8C/518R9Vi5BeWq8Hbv04x0=";

  postPatch = ''
    substituteInPlace .npmrc \
      --replace-fail "package-lock=false" "package-lock=true"

    cp ${./package-lock.json} package-lock.json
  '';

  meta = {
    description = "The semver parser for node (the one npm uses), with a CLI";
    homepage = "https://github.com/npm/node-semver";
    changelog = "https://github.com/npm/node-semver/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.isc;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "node-semver";
    platforms = lib.platforms.all;
  };
})
