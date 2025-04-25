# {
#  description = "Flutter";
#  inputs = {
#    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#    flake-utils.url = "github:numtide/flake-utils";
#  };
#  outputs = { self, nixpkgs, flake-utils }:
#    flake-utils.lib.eachDefaultSystem (system:
#      let
#        pkgs = import nixpkgs {
#          inherit system;
#          config = {
#            android_sdk.accept_license = true;
#            allowUnfree = true;
#          };
#        };
#        buildToolsVersion = "34.0.0";
#        androidComposition = pkgs.androidenv.composeAndroidPackages {
#          buildToolsVersions = [ buildToolsVersion "28.0.3" ];
#          platformVersions = [ "34" "28" ];
#          abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
#        };
#        androidSdk = androidComposition.androidsdk;
#      in {
#        devShell = with pkgs;
#          mkShell rec {
#            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
#            buildInputs = [
#              flutter
#              androidSdk # The customized SDK that we've made above
#              jdk17
#	      pkg-config
#              ninja ];
#          };
#      });
#}

{
  description = "Flutter environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        androidEnv = pkgs.androidenv.override { licenseAccepted = true; };
        androidComposition = androidEnv.composeAndroidPackages {
          cmdLineToolsVersion =
            "8.0"; # emulator related: newer versions are not only compatible with avdmanager
          platformToolsVersion = "34.0.4";
          buildToolsVersions = [ "34.0.0" ];
          platformVersions = [ "34" ];
          abiVersions = [
            "x86_64"
          ]; # emulator related: on an ARM machine, replace "x86_64" with
          # either "armeabi-v7a" or "arm64-v8a", depending on the architecture of your workstation.
          includeNDK = false;
          includeSystemImages =
            true; # emulator related: system images are needed for the emulator.
          systemImageTypes = [ "google_apis" "google_apis_playstore" ];
          includeEmulator =
            true; # emulator related: if it should be enabled or not
          useGoogleAPIs = true;
          extraLicenses = [
            "android-googletv-license"
            "android-sdk-arm-dbt-license"
            "android-sdk-license"
            "android-sdk-preview-license"
            "google-gdk-license"
            "intel-android-extra-license"
            "intel-android-sysimage-license"
            "mips-android-sysimage-license"
          ];
        };
        androidSdk = androidComposition.androidsdk;
      in {
        devShell = with pkgs;
          mkShell rec {
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
			#CHROME_EXECUTABLE = "google-chrome-stable";
            JAVA_HOME = jdk21.home;
            FLUTTER_ROOT = flutter;
            DART_ROOT = "${flutter}/bin/cache/dart-sdk";
            GRADLE_OPTS =
              "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/33.0.2/aapt2";
            QT_QPA_PLATFORM =
              "wayland;xcb"; # emulator related: try using wayland, otherwise fall back to X
            # NB: due to the emulator's bundled qt version, it currently does not start with QT_QPA_PLATFORM="wayland".
            # Maybe one day this will be supported.
            buildInputs = [
              androidSdk
              flutter
              gradle
              jdk21
              protobuf
              buf
              pandoc
              libsecret.dev
              gtk3.dev
              grpcurl
	      #google-chrome
              chromedriver
              pkg-config
            ];
            # emulator related: vulkan-loader and libGL shared libs are necessary for hardware decoding
            LD_LIBRARY_PATH =
              "${pkgs.lib.makeLibraryPath [ vulkan-loader libGL ]}";
            CMAKE_PREFIX_PATH =
              "${pkgs.lib.makeLibraryPath [ libsecret.dev gtk3.dev ]}";
            # Globally installed packages, which are installed through `dart pub global activate package_name`,
            # are located in the `$PUB_CACHE/bin` directory.
            shellHook = ''
              if [ -z "$PUB_CACHE" ]; then
                export PATH="$PATH:$HOME/.pub-cache/bin"
              else
                export PATH="$PATH:$PUB_CACHE/bin"
              fi

              dart pub global activate protoc_plugin
            '';
          };
      });
}
