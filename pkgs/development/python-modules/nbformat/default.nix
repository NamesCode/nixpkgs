{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, hatchling
, hatch-nodejs-version
, fastjsonschema
, jsonschema
, jupyter-core
, traitlets
, pep440
, pytestCheckHook
, testpath
}:

buildPythonPackage rec {
  pname = "nbformat";
  version = "5.10.3";
  format = "pyproject";
  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-YO1ekQ73xiZLh9ZE8naxtJ4kARkw3u9UYFGI3eshFoU=";
  };

  nativeBuildInputs = [
    hatchling
    hatch-nodejs-version
  ];

  propagatedBuildInputs = [
    fastjsonschema
    jsonschema
    jupyter-core
    traitlets
  ];

  nativeCheckInputs = [
    pep440
    pytestCheckHook
    testpath
  ];

  # Some of the tests use localhost networking.
  __darwinAllowLocalNetworking = true;

  meta = {
    description = "The Jupyter Notebook format";
    mainProgram = "jupyter-trust";
    homepage = "https://jupyter.org/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ fridh globin ];
  };
}
