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

PHP_DISTRO_DEBIAN_SNAPSHOT = "20211226T204637Z"

PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT = "20211227T030445Z"

PHP_DISTRO_SHA256s = {
    "amd64": {
        "debian10": {
            "main": "5865abfef15e9be4113532c953f522e9f7679b4a282d43d1a943d51abb17ece1",
            "updates": "97090fbf12a9aa3858d740eac12840777c232ec917985828b5d1d38239e92cdb",
            "security": "053c4046d90c52606c72fc1c5c87368bf9b47746355c72c6406e31d6a5463c88",
            "sury-php": "23d793d61b66d64b3535bfc9a82941df6c8415a211a7d13cc7c025ffdcc773ff",
        },
    },
    "arm64": {
        "debian10": {
            "main": "a850aaac1a83c41608ee2ef9451c90fe485ff3afb3374018af792aed8678de2a",
            "updates": "f4086dc7ce3cd5150eb051ed4617f6c6ee23915b9b07092deeaff98065f6157f",
            "security": "a78d2e663f0653af229b5c1b518ad636b704ca7da6ed86c21f2d39b55bb7eb66",
            "sury-php": "7e7263dc1ddce0b4939454d7cc9c02735def4ac0ec384056b62a2bf559a3fa37",
        },
    },
}
