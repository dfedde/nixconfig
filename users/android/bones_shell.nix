# # react-native-android-expo-jdk17-shell.nix
# {
#   pkgs ? import <nixpkgs> {
#     config = {
#       android_sdk.accept_license = true;
#       allowUnfree = true;
#     };
#   },
# }:
# let
#   android = pkgs.composeAndroidPackages {
#     platformVersions = [ "34" ];
#     buildToolsVersions = [ "34.0.0" ];
#     abiVersions = [ "arm64-v8a" ];
#   };
# in
# pkgs.mkShell {
#   buildInputs = with pkgs; [
#     android.androidsdk
#     curl
#     nodePackages.expo-cli # Adding Expo CLI
#     git
#     nodejs_20
#     openjdk17
#     unzip
#     yarn
#     zip
#   ];
#
#   shellHook = ''
#     # export ANDROID_HOME=${pkgs.androidsdk}/libexec
#     export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin:$PATH
#     export JAVA_HOME=${pkgs.openjdk17}/lib
#     export PATH=$JAVA_HOME/bin:$PATH
#
#     # Ensure android SDK is up-to-date
#     if [ ! -d "$ANDROID_HOME/platforms/android-30" ]; then
#       echo "Installing Android SDK platforms..."
#       yes | sdkmanager --update
#       sdkmanager "platforms;android-30" "build-tools;30.0.3"
#     fi
#
#     echo "React Native Android build environment with Expo and JDK 17 is ready!"
#   '';
# }

{
  pkgs ? import <nixpkgs> {
    config = {
      android_sdk.accept_license = true;
      allowUnfree = true;
    };
  },
}:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [
      "35"
    ];
    buildToolsVersions = [
      "35.0.0"
      "34.0.0"
    ];
    systemImageTypes = [ "google_apis_playstore" ];
    extraLicenses = [ "android-sdk-preview-license" ];
    abiVersions = [
      "armeabi-v7a"
      "arm64-v8a"
    ];
    includeNDK = true;
    ndkVersions = [ "26.1.10909125" ];
    cmakeVersions = [ "3.22.1" ];
    # includeExtras = [
    #   "extras;google;auto"
    # ];
  };
  fhs = pkgs.buildFHSUserEnv {
    name = "android-env";
    targetPkgs =
      pkgs: with pkgs; [
        git
        gitRepo
        gnupg
        # python2
        curl
        procps
        openssl
        gnumake
        nettools
        androidComposition.androidsdk
        jdk
        schedtool
        util-linux
        m4
        gperf
        perl
        libxml2
        zip
        unzip
        bison
        flex
        lzop
        python3
      ];
    multiPkgs =
      pkgs: with pkgs; [
        zlib
        ncurses5
      ];
    runScript = "bash";
    profile = ''
      export ALLOW_NINJA_ENV=true
      export USE_CCACHE=1
      export ANDROID_JAVA_HOME=${pkgs.jdk.home}
      export LD_LIBRARY_PATH=/usr/lib:/usr/lib32
      export ANDROID_HOME=${androidComposition.androidsdk}/libexec/android-sdk
    '';
  };
in
pkgs.stdenv.mkDerivation {
  name = "android-env-shell";
  nativeBuildInputs = [ fhs ];
  shellHook = "exec android-env";

}
