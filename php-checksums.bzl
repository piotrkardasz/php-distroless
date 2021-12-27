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
            "main": "2ddaa7dbee2708338fc177812881720af46773b3fab181dee4c30ad0a0b43f3d",
            "updates": "ecbd3cb65f1da7ef5a5f98b0e7474df382d94ad5b9ba6dd1d88a02f779f1c29f",
            "security": "d0e556f4dc21ccd2697b766ebbb045e13d701cf937fe77c438689843e80c5603",
            "sury-php": "23d793d61b66d64b3535bfc9a82941df6c8415a211a7d13cc7c025ffdcc773ff",
        },
    },
    "arm64": {
        "debian10": {
            "main": "50e0b4d1791e396ff2df245aa555940782ec0331be42711882d72cdfd4546fbe",
            "updates": "2809946eba4a332908fb70094af4ef48948a19c322b77572253b54d6bcb96963",
            "security": "6977071ffba24d9b47489e42d5cb58e364b0eff647b0c4c646619e093d1b85cc",
            "sury-php": "7e7263dc1ddce0b4939454d7cc9c02735def4ac0ec384056b62a2bf559a3fa37",
        },
    },
}
