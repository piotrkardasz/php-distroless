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

PHP_DISTRO_DEBIAN_SNAPSHOT = "20211228T091540Z"

PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT = "20211229T101346Z"

PHP_DISTRO_SHA256s = {
    "amd64": {
        "debian10": {
            "main": "7deb781b178397211c0a34cac5a9f3e43c4d6446bcce4f5d8c660579fa6af772",
            "updates": "f2fd4dd18091bcade096fee5ba70949dd8c7d6275ac269146af7ad11009a6db5",
            "security": "9c47b7fb6128a848c92d513a5377280cfa44f4f85eae39b6e3b4f6bde9bcb453",
            "sury-php": "23d793d61b66d64b3535bfc9a82941df6c8415a211a7d13cc7c025ffdcc773ff",
        },
    },
    "arm64": {
        "debian10": {
            "main": "04b3db90c4705bc792bc1d318330cd8b3db011f77af2b5e1e3079bc20d415ecf",
            "updates": "06714ea1bc5cb19db035c050c30a6e2b8bd55456d9874f2df3c7d6ad10939189",
            "security": "5a0477c5d6807c42c37d13451dc1e1fa4e09e2c618279d5ce46f1ea03af986ae",
            "sury-php": "7e7263dc1ddce0b4939454d7cc9c02735def4ac0ec384056b62a2bf559a3fa37",
        },
    },
}
