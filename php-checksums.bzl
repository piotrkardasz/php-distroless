# WARNING!!!
# DO NOT MODIFY THIS FILE DIRECTLY.
# TO GENERATE THIS RUN: ./updateWorkspaceSnapshotsForPHP.sh

PHP_DISTRO_BASE_ARCHITECTURES = ["amd64", "arm64"]

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
]

PHP_DISTRO_DEBIAN_SNAPSHOT = "20210729T144530Z"

PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT = "20210729T023407Z"

PHP_DISTRO_SHA256s = {
    "amd64": {
        "debian10": {
            "main": "afe7cb263af91703af8d75e9c6ca7142811e930440e5767e3e4b51cdf852056b",
            "updates": "e2998294f7ddef7e2ab3c1da87bba50da7f03927351d1807c272112db411661e",
            "security": "cc35a3d27b6bb1c9d9a37b95d37e3aecee61d74b523e7179ced1742a43859b9a",
            "sury-php": "a1e100c64ac96c2ea6002a4d6696a6eef3fc3ae7609894123a951b147d3da7c5",
        },
    },
    "arm64": {
        "debian10": {
            "main": "1a20b91043ffb175d4fdf00790c5a960773a8d96bf9be4817362bf0ed10a969b",
            "updates": "2ae1361d634e401fe6b2edb08f0f5b62f77360a8768c99adf41f5833d18b04f7",
            "security": "ba1ce3778b3c701e6d4480b6b20a09bdc41fd64a173f4b230c9084ab1d5b90ad",
            "sury-php": "c5a4691a9c767b95d409ac3576f2df7473b5ee43815fb4404e673b08099098b8",
        },
    },
}
