{ lib, stdenv, fetchurl, libX11, libXinerama, buildPackages }:

stdenv.mkDerivation  rec {
  pname = "libfakeXinerama";
  version = "0.1.0";

  src = fetchurl {
    url = "https://www.xpra.org/src/${pname}-${version}.tar.bz2";
    sha256 = "0gxb8jska2anbb3c1m8asbglgnwylgdr44x9lr8yh91hjxsqadkx";
  };

  buildInputs = [ libX11 libXinerama ];

  nativeBuildInputs = [ buildPackages.stdenv.cc ];

  buildPhase = ''
    runHook preBuild

    ${buildPackages.stdenv.cc}/bin/cc -O2 -Wall fakeXinerama.c -fPIC -o libfakeXinerama.so.1.0 -shared

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm555 libfakeXinerama.so.1.0 -t "$out/lib"
    ln -s libfakeXinerama.so.1.0 "$out/lib/libXinerama.so.1.0"
    ln -s libXinerama.so.1.0 "$out/lib/libXinerama.so.1"
    ln -s libXinerama.so.1 "$out/lib/libXinerama.so"

    runHook postInstall
  '';

  meta = {
    homepage = "http://xpra.org/";
    description = "fakeXinerama for Xpra";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nickcao ];
    license = lib.licenses.mit;
  };
}
