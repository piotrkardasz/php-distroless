#/bin/sh

set -o errexit
set -o xtrace

cp php-checksums.bzl php-checksums.bzl~
cp php_package_bundle_amd64_debian10.versions php_package_bundle_amd64_debian10.versions~
cp php_package_bundle_arm64_debian10.versions php_package_bundle_arm64_debian10.versions~
cp php8_bundle_amd64_debian10.versions php8_bundle_amd64_debian10.versions~
cp php8_bundle_arm64_debian10.versions php8_bundle_arm64_debian10.versions~
cp php8plus_bundle_amd64_debian10.versions php8plus_bundle_amd64_debian10.versions~
cp php8plus_bundle_arm64_debian10.versions php8plus_bundle_arm64_debian10.versions~

YEAR=`date +"%Y"`
MONTH=`date +"%m"`

# Fetch all the latest snapshot versions for the current month

PHP_DISTRO_DEBIAN_SNAPSHOT=`curl -s "https://snapshot.debian.org/archive/debian/?year=$YEAR;month=$MONTH" 2>&1 | grep -oE "[0-9]+T[0-9]+Z" | tail -n1`
PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT=`curl -s "https://snapshot.debian.org/archive/debian-security/?year=$YEAR;month=$MONTH" 2>&1 | grep -oE "[0-9]+T[0-9]+Z" | tail -n1`

if [ -z "$PHP_DISTRO_DEBIAN_SNAPSHOT" ]
then
    echo "No debian snapshot version found";
    exit 0
fi

if [ -z "$PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT" ]
then
    echo "No debian security snapshot version found";
    exit 0
fi

cat > php-checksums.bzl <<EOF
# WARNING!!!
# DO NOT MODIFY THIS FILE DIRECTLY.
# TO GENERATE THIS RUN: ./updateWorkspaceSnapshotsForPHP.sh

PHP_DISTRO_BASE_ARCHITECTURES = ["amd64", "arm64"]
PHP_VERSIONS = ["7.4", "8.0", "8.1"]

# Exceptions:
# - s390x doesn't have libunwind8.
#   https://github.com/GoogleContainerTools/distroless/pull/612#issue-500157699
# - ppc64le doesn't have stretch security-channel.
#   https://github.com/GoogleContainerTools/distroless/pull/637#issuecomment-728139611
# - arm needs someone with available hardware to generate:
#   //experimental/python2.7/ld.so.arm.cache
PHP_DISTRO_ARCHITECTURES = PHP_DISTRO_BASE_ARCHITECTURES

PHP_DISTRO_VERSIONS = [
    ("debian10", "buster"),
#    ("debian11", "bullseye"),
]

PHP_DISTRO_DEBIAN_SNAPSHOT = "$PHP_DISTRO_DEBIAN_SNAPSHOT"

PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT = "$PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT"

PHP_DISTRO_SHA256s = {
    "amd64": {
        "debian10": {
            "main": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/buster/main/binary-amd64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
            "updates": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/buster-updates/main/binary-amd64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
            "security": "`curl -s https://snapshot.debian.org/archive/debian-security/$DEBIAN_SECURITY_SNAPSHOT/dists/buster/updates/main/binary-amd64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
            "sury-php": "`curl -H "User-Agent: Mozilla/5.0" -s https://packages.sury.org/php/dists/buster/main/binary-amd64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
        },
        "debian11": {
            "main": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/bullseye/main/binary-amd64/Packages.xz 2>&1 | sha256sum | cut -d " " -f 1`",
            "updates": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/bullseye-updates/main/binary-amd64/Packages.xz 2>&1 | sha256sum | cut -d " " -f 1`",
            "security": "`curl -s https://snapshot.debian.org/archive/debian-security/$DEBIAN_SECURITY_SNAPSHOT/dists/bullseye-security/main/binary-amd64/Packages.xz 2>&1 | sha256sum | cut -d " " -f 1`",
            "sury-php": "`curl -H "User-Agent: Mozilla/5.0" -s https://packages.sury.org/php/dists/bullseye/main/binary-amd64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
        },
    },
    "arm64": {
        "debian10": {
            "main": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/buster/main/binary-arm64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
            "updates": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/buster-updates/main/binary-arm64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
            "security": "`curl -s https://snapshot.debian.org/archive/debian-security/$DEBIAN_SECURITY_SNAPSHOT/dists/buster/updates/main/binary-arm64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
            "sury-php": "`curl -H "User-Agent: Mozilla/5.0" -s https://packages.sury.org/php/dists/buster/main/binary-arm64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
        },
        "debian11": {
            "main": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/bullseye/main/binary-arm64/Packages.xz 2>&1 | sha256sum | cut -d " " -f 1`",
            "updates": "`curl -s https://snapshot.debian.org/archive/debian/$DEBIAN_SNAPSHOT/dists/bullseye-updates/main/binary-arm64/Packages.xz 2>&1 | sha256sum | cut -d " " -f 1`",
            "security": "`curl -s https://snapshot.debian.org/archive/debian-security/$DEBIAN_SECURITY_SNAPSHOT/dists/bullseye-security/main/binary-arm64/Packages.xz 2>&1 | sha256sum | cut -d " " -f 1`",
            "sury-php": "`curl -H "User-Agent: Mozilla/5.0" -s https://packages.sury.org/php/dists/bullseye/main/binary-arm64/Packages.gz 2>&1 | sha256sum | cut -d " " -f 1`",
        },
    },
}
EOF
# Rebuild package set

bazel clean
bazel build //package_manager:dpkg_parser.par
bazel build @php_package_bundle_amd64_debian10//file:packages.bzl
bazel build @php_package_bundle_arm64_debian10//file:packages.bzl

bazel build @php8_bundle_amd64_debian10//file:packages.bzl
bazel build @php8_bundle_arm64_debian10//file:packages.bzl

bazel build @php8plus_bundle_amd64_debian10//file:packages.bzl
bazel build @php8plus_bundle_arm64_debian10//file:packages.bzl


# Check if any of the version lock files are updated

if diff -w php_package_bundle_amd64_debian10.versions php_package_bundle_amd64_debian10.versions~ &&
  diff -w php_package_bundle_arm64_debian10.versions php_package_bundle_arm64_debian10.versions~ &&

  diff -w php8_bundle_amd64_debian10.versions php8_bundle_amd64_debian1.versions~ &&
  diff -w php8_bundle_arm64_debian10.versions php8_bundle_arm64_debian10.versions~ &&

  diff -w php8plus_bundle_amd64_debian10.versions php8plus_bundle_amd64_debian1.versions~ &&
  diff -w php8plus_bundle_arm64_debian10.versions php8plus_bundle_arm64_debian10.versions~  ; then
    echo "No changes detected to php_package_bundle versions."
    mv php-checksums.bzl~ php-checksums.bzl
    mv php_package_bundle_amd64_debian10.versions~ php_package_bundle_amd64_debian10.versions
    mv php_package_bundle_arm64_debian10.versions~ php_package_bundle_arm64_debian10.versions
    mv php8_bundle_amd64_debian10.versions~ php8_bundle_amd64_debian10.versions
    mv php8_bundle_arm64_debian10.versions~ php8_bundle_arm64_debian10.versions
    mv php8plus_bundle_amd64_debian10.versions~ php8plus_bundle_amd64_debian10.versions
    mv php8plus_bundle_arm64_debian10.versions~ php8plus_bundle_arm64_debian10.versions
else
    echo "Changes detected to php_package_bundle version files. Please update snapshots."
    rm *~
fi
