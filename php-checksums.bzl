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

PHP_DISTRO_DEBIAN_SNAPSHOT = "20211228T153940Z"

PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT = "20211230T150549Z"

PHP_DISTRO_SHA256s = {
    "amd64": {
        "debian10": {
            "main": "e959fc9bd3847bfd547ef669254141607653429b2937bdbd8a06f48e2e43fd99",
            "updates": "68c637a20a2baa97de92553791febfbd848fa1daa53cc578c7845265a09f5ddb",
            "security": "acb63048478cf9a223851ac63914062a0acb88d9e25939f6b95cdbcdca102927",
            "sury-php": "23d793d61b66d64b3535bfc9a82941df6c8415a211a7d13cc7c025ffdcc773ff",
        },
        "debian11": {
            "main": "21c0f080888c997bbfbd05b90362d6c2d6e53dfa607f03bae7be80157deebaf5",
            "updates": "23acda4893192e8a5f03dbe4f6a172c845b9af93933ff316eb9f44e996ede08a",
            "security": "b98b69779596cbcb81a61d51b80eb6765d75e3e3a202704f4672460466c67e89",
            "sury-php": "b25851c028b318db0dad45e8ce02739882fd1d4f471eeccd02141c7f6b1d529d",
        },
    },
    "arm64": {
        "debian10": {
            "main": "5ed23cbe81c7b1644cbb50ae00d84f3c286b0f1baa98f3b42b172613c74a22b0",
            "updates": "8a13fed44f34a3923c14b31d4ca00c7d2dc44e6d8eebbecf2510f1060e7e1d01",
            "security": "859c5ff15cf66ecee0d60a3592ea1f7739aae01de8888a7a5892311b5d071375",
            "sury-php": "7e7263dc1ddce0b4939454d7cc9c02735def4ac0ec384056b62a2bf559a3fa37",
        },
        "debian11": {
            "main": "a93947c2f4e7ce403cb5d19bd1a001e066491f62de9a4fa6ac2ccbab4d812a8f",
            "updates": "4f4141a97f39447b44da97d1e41454fca419b0553d5571df226175e175ea6217",
            "security": "a09f404d2f1a969a44b4d8ea7707e807fd35793b61f5081d189f61ba2b2887ab",
            "sury-php": "0e1c387db6146dd1fa3834dd6ec0e6be7af256ba5beb57702dc633e50279ea12",
        },
    },
}
