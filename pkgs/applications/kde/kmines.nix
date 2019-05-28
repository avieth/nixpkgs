{
  mkDerivation, lib,
  extra-cmake-modules,
  qtdeclarative, kdelibs4support, libkdegames
}:

mkDerivation {
  name = "kmines";
  meta = {
    license = with lib.licenses; [ gpl2 ];
    maintainers = [ ];
  };
  nativeBuildInputs = [ extra-cmake-modules ];
  buildInputs = [ kdelibs4support libkdegames qtdeclarative ];
  propagatedUserEnvPkgs = [ ];
}
