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

PHP_DISTRO_DEBIAN_SNAPSHOT = "20211227T152656Z"

PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT = "20211227T174244Z"

PHP_DISTRO_SHA256s = {
    "amd64": {
        "debian10": {
            "main": "ccda0b399b67616ecf4230efbcc55a06f370d087944a0a6cca6b2f58197af898",
            "updates": "5cb8ccc7abf31a228174c3f6014aff4133b43c515d54b7a936c84ac919665b94",
            "security": "d804b1f97edf6028e3bca506342abc919f2d9e9850e1e709b34590db441f43fb",
            "sury-php": "23d793d61b66d64b3535bfc9a82941df6c8415a211a7d13cc7c025ffdcc773ff",
        },
    },
    "arm64": {
        "debian10": {
            "main": "285308fe718e751c8a346081fcab2efac2df6ece957b3ff2598b3b99faa78cfe",
            "updates": "e3f8ea5e1536f8fc176f0ac5d0a7ad99765f4d68c356c903363f8d71f776df71",
            "security": "07a2ad8d0f675d7881ad5e6a69b2b873f8a44f6f187a0e996a4eefd51c20cc14",
            "sury-php": "7e7263dc1ddce0b4939454d7cc9c02735def4ac0ec384056b62a2bf559a3fa37",
        },
    },
}
