{ pkgs, lib, ... }:

self: _: {

  # From https://github.com/NixOS/nixpkgs/pull/185087
  roundrobin = self.buildPythonPackage rec {
    pname = "roundrobin";
    version = "0.0.4";

    src = pkgs.fetchFromGitHub {
      owner = "linnik";
      repo = pname;
      rev = version;
      hash = "sha256-eedE4PE43sbJE/Ktrc31KjVdfqe2ChKCYUNIl7fir0E=";
    };

    meta = with lib; {
      description = "This is rather small collection of round robin utilites";
      homepage = "https://github.com/linnik/roundrobin";
      license = licenses.mit;
    };
  };

  # From https://github.com/NixOS/nixpkgs/pull/199746
  locust = self.buildPythonPackage rec {
    pname = "locust";
    version = "2.19.1";
    format = "pyproject";

    src = pkgs.fetchFromGitHub {
      owner = "locustio";
      repo = "locust";
      rev = version;
      hash = "sha256-M6uNJMznUCRy1+bpjtrtukrFJq+TcqyTKP6INhgC7+A=";
    };

    patchPhase = ''
      echo 'version = "${version}"' > locust/_version.py
    '';

    SETUPTOOLS_SCM_PRETEND_VERSION = version;
    nativeBuildInputs = [ pkgs.python311Packages.setuptools-scm ];

    propagatedBuildInputs = with pkgs.python3Packages; [
      requests
      flask-basicauth
      python-dotenv
      flask-cors
      msgpack
      psycopg2
      gevent
      pyzmq
      geventhttpclient
      psutil
      typing-extensions
      configargparse
      setuptools
      setuptools-scm
    ];

    meta = with lib; {
      description = "A load testing tool";
      homepage = "https://locust.io/";
      license = licenses.mit;
    };
  };
}
