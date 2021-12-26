workspace(name = "distroless")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "a8d6b1b354d371a646d2f7927319974e0f9e52f73a2452d2b3877118169eb6bb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.23.3/rules_go-v0.23.3.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.23.3/rules_go-v0.23.3.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("//package_manager:dpkg.bzl", "dpkg_list", "dpkg_src")
load(
    "//:checksums.bzl",
    "ARCHITECTURES",
    "BASE_ARCHITECTURES",
    "DEBIAN_SECURITY_SNAPSHOT",
    "DEBIAN_SNAPSHOT",
    "SHA256s",
    "VERSIONS",
)
load(
    "//:php-checksums.bzl",
    "PHP_DISTRO_ARCHITECTURES",
    "PHP_DISTRO_BASE_ARCHITECTURES",
    "PHP_DISTRO_DEBIAN_SECURITY_SNAPSHOT",
    "PHP_DISTRO_DEBIAN_SNAPSHOT",
    "PHP_DISTRO_SHA256s",
    "PHP_DISTRO_VERSIONS",
)

[
    dpkg_src(
        name = arch + "_" + name,
        arch = arch,
        distro = distro,
        sha256 = SHA256s[arch][name]["main"],
        snapshot = DEBIAN_SNAPSHOT,
        url = "https://snapshot.debian.org/archive",
    )
    for arch in ARCHITECTURES
    for (name, distro) in VERSIONS
]

[
    dpkg_src(
        name = arch + "_" + name + "_updates",
        arch = arch,
        distro = distro + "-updates",
        sha256 = SHA256s[arch][name]["updates"],
        snapshot = DEBIAN_SNAPSHOT,
        url = "https://snapshot.debian.org/archive",
    )
    for arch in ARCHITECTURES
    for (name, distro) in VERSIONS
]

[
    dpkg_src(
        name = arch + "_" + name + "_sury-php",
        arch = arch,
        distro = distro,
        package_prefix = "https://packages.sury.org/php/",
        packages_gz_url = "https://packages.sury.org/php/dists/{}/main/binary-{}/Packages.gz".format(distro, arch),

        sha256 = PHP_DISTRO_SHA256s[arch][name]["sury-php"],
    )
    for arch in PHP_DISTRO_ARCHITECTURES
    for (name, distro) in PHP_DISTRO_VERSIONS
]

[
    dpkg_src(
        name = arch + "_" + name + "_security",
        package_prefix = "https://snapshot.debian.org/archive/debian-security/{}/".format(DEBIAN_SECURITY_SNAPSHOT),
        packages_gz_url = "https://snapshot.debian.org/archive/debian-security/{}/dists/{}/updates/main/binary-{}/Packages.gz".format(DEBIAN_SECURITY_SNAPSHOT, distro, arch),
        sha256 = SHA256s[arch][name]["security"],
    )
    for arch in ARCHITECTURES
    for (name, distro) in VERSIONS
    if "security" in SHA256s[arch][name]
]

[
    dpkg_src(
        name = arch + "_" + name + "_backports",
        arch = arch,
        distro = distro + "-backports",
        sha256 = SHA256s[arch][name]["backports"],
        snapshot = DEBIAN_SNAPSHOT,
        url = "https://snapshot.debian.org/archive",
    )
    for arch in ARCHITECTURES
    for (name, distro) in VERSIONS
    if "backports" in SHA256s[arch][name]
]

[
    dpkg_list(
        name = "php_package_bundle_" + arch + "_debian10",
        packages = [
            #php, php-fpm
            "libmagic1",
            "libmagic-mgc",
            "mime-support",
            "libsystemd0",
            "libgcrypt20",
            "libgpg-error0",
            "liblz4-1",
            "libacl1",
            "libattr1",
            "libapparmor1",
            "libpcre2-8-0",
            "libncurses6", #cli
            "libtinfo6", #cli
            "libedit2", #cli
            "libbsd0",
            "libargon2-1", #argon
            "libcurl4", #curl
            "libcom-err2",
            "libonig5", #mbstring
            "libsodium23", #sodium
            "libsqlite3-0", #sqlite
            "libssl1.1", #ssl
            "libxml2", #xml
            "liblzma5", #xml
            "libxslt1.1", #xml
            "zlib1g", #zlib
            "libzip4", #zip
            "libmcrypt4", #mcrypt
            "libgd3", #gd
            "libfontconfig1", #gd
            "libfreetype6", #gd
            "libjpeg62-turbo", #gd
            "libpng16-16", #gd
            "libtiff5", #gd
            "libwebp6", #gd
            "libxpm4", #gd
            "libexpat1", #gd
            "libuuid1", #gd
            "libx11-6", #gd
            "libxcb1", #gd
            "libx11-data", #gd
            "libzstd1", #gd
            "libjbig0", #gd
            "libxau6", #gd
            "libxdmcp6", #gd
            "libicu65", #intl
            "ucf",
        ],
        sources = [
            "@" + arch + "_debian10_sury-php//file:Packages.json",
            "@" + arch + "_debian10_security//file:Packages.json",
            "@" + arch + "_debian10_updates//file:Packages.json",
            "@" + arch + "_debian10//file:Packages.json",
        ],
    )
    for arch in ARCHITECTURES
]

[
    dpkg_list(
        name = "php8_bundle_" + arch + "_debian10",
        packages = [
            "php8.0",
            "php8.0-common",
            "php8.0-opcache",
            "php8.0-mcrypt",
            "php8.0-cli",
            "php8.0-fpm",
            "php8.0-readline",
            "php8.0-gd",
            "php8.0-curl",
            "php8.0-mysql",
            "php8.0-zip",
            "php8.0-intl",
            "php8.0-mbstring",
            "php8.0-xml",
        ],
        sources = [
            "@" + arch + "_debian10_sury-php//file:Packages.json",
        ],
    )
    for arch in ARCHITECTURES
]

[
    dpkg_list(
        name = "package_bundle_" + arch + "_debian10",
        packages = [
            "libc6",
            "base-files",
            "ca-certificates",
            "openssl",
            "libssl1.1",
            "libbz2-1.0",
            "libdb5.3",
            "libffi6",
            "liblzma5",
            "libexpat1",
            "libreadline7",
            "libsqlite3-0",
            "mime-support",
            "netbase",
            "readline-common",
            "tzdata",

            #c++
            "libgcc1",
            "libgomp1",
            "libstdc++6",

            #java
            "zlib1g",
            "libjpeg62-turbo",
            "libpng16-16",
            "liblcms2-2",
            "libfreetype6",
            "fonts-dejavu-core",
            "fontconfig-config",
            "libfontconfig1",
            "libuuid1",
            "openjdk-11-jre-headless",
            "openjdk-11-jdk-headless",
            "libc-bin",

            #python
            "dash",
            "libc-bin",
            "libpython2.7-minimal",
            "libpython2.7-stdlib",
            "python2.7-minimal",

            #python3
            "libmpdec2",
            "libpython3.7-minimal",
            "libpython3.7-stdlib",
            "libtinfo6",
            "libuuid1",
            "libncursesw6",
            "python3-distutils",
            "python3.7-minimal",
        ] + (["libunwind8"] if arch in BASE_ARCHITECTURES else []),
        sources = [
            "@" + arch + "_debian10_security//file:Packages.json",
            "@" + arch + "_debian10_updates//file:Packages.json",
            "@" + arch + "_debian10//file:Packages.json",
        ],
    )
    for arch in ARCHITECTURES
]

# For Jetty
http_archive(
    name = "jetty",
    build_file = "//java:BUILD.jetty",
    sha256 = "1b9ec532cd9b94550fad655e066a1f9cc2d350a1c79daea85d5c56fdbcd9aaa8",
    strip_prefix = "jetty-distribution-9.4.22.v20191022/",
    type = "tar.gz",
    urls = ["https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.22.v20191022/jetty-distribution-9.4.22.v20191022.tar.gz"],
)

# Node (https://nodejs.org/en/about/releases/)
# Follow Node's maintainence schedule and support all LTS versions that are not end of life
http_archive(
    name = "nodejs10_amd64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "7a70083a73719a3c7846533923d5c4e955405c2b4ba1c1abd95ed21ae8b52775",
    strip_prefix = "node-v10.24.1-linux-x64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v10.24.1/node-v10.24.1-linux-x64.tar.gz"],
)

http_archive(
    name = "nodejs12_amd64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "2898ac962602443fedeaaccf61b33f127c97f7c9d7b23fbe0d78a4d20b69db0b",
    strip_prefix = "node-v12.22.2-linux-x64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v12.22.2/node-v12.22.2-linux-x64.tar.gz"],
)

http_archive(
    name = "nodejs14_amd64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "48cc87b7adb13f479643166a16514861556d0936761b317a3b65f4fbbb265b4d",
    strip_prefix = "node-v14.17.2-linux-x64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v14.17.2/node-v14.17.2-linux-x64.tar.gz"],
)

http_archive(
    name = "nodejs10_arm64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "0ae4931d0ea779ecb237c1fc9f4a27271b0054b1efabc783863478913fe6caa6",
    strip_prefix = "node-v10.24.1-linux-arm64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v10.24.1/node-v10.24.1-linux-arm64.tar.gz"],
)

http_archive(
    name = "nodejs12_arm64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "40f4a6a887e3ab8675e71bdc544353e078775074ec9f7911cfe3827ad68007fb",
    strip_prefix = "node-v12.22.2-linux-arm64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v12.22.2/node-v12.22.2-linux-arm64.tar.gz"],
)

http_archive(
    name = "nodejs14_arm64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "05117e74f424fd4ab744c3013c77906c5fe4a19fa22ce624a21986ce152fd258",
    strip_prefix = "node-v14.17.2-linux-arm64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v14.17.2/node-v14.17.2-linux-arm64.tar.gz"],
)

# For the debug image
http_file(
    name = "busybox_amd64",
    executable = True,
    sha256 = "51fcb60efbdf3e579550e9ab893730df56b33d0cc928a2a6467bd846cdfef7d8",
    urls = ["https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64"],
)

http_file(
    name = "busybox_arm",
    executable = True,
    sha256 = "cd04052b8b6885f75f50b2a280bfcbf849d8710c8e61d369c533acf307eda064",
    urls = ["https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-armv7l"],
)

http_file(
    name = "busybox_arm64",
    executable = True,
    sha256 = "141adb1b625a6f44c4b114f76b4387b4ea4f7ab802b88eb40e0d2f6adcccb1c3",
    urls = ["https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-armv8l"],
)

http_file(
    name = "busybox_s390x",
    executable = True,
    sha256 = "48d13ac057046b95ba58921958be639cc3a179ac888cdd65aacd7a69139aa857",
    urls = ["https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-s390x"],
)

# To update ppc64le busybox binary (#723)
# Get the latest commit hash from dist-ppc64le branch of docker-library repo.
# Substitute it in the link: https://github.com/docker-library/busybox/raw/<latest-commit-hash>/stable/musl/busybox.tar.xz
# Update the sha256 value. Since github api doesn't give sha256 value, it can be obtained using sha256sum command.
http_file(
    name = "busybox_ppc64le",
    executable = True,
    sha256 = "469297ea9293df0dcb6c3f8d344eaf9f9b6ec1732696ffe86994f87c3600423b",
    urls = ["https://github.com/docker-library/busybox/raw/c0125333c4c3dfa4b9e5fd9fe6fbb875242f3613/stable/musl/busybox.tar.xz"],
)

# Docker rules.
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
    strip_prefix = "rules_docker-0.17.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load(
    "@io_bazel_rules_docker//python:image.bzl",
    _py_image_repos = "repositories",
)

_py_image_repos()

# Have the java_image dependencies for testing.
load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)

_java_image_repos()

# Have the go_image dependencies for testing.
load(
    "@io_bazel_rules_docker//go:image.bzl",
    _go_image_repos = "repositories",
)

_go_image_repos()

# Rust repositories
http_archive(
    name = "rules_rust",
    sha256 = "42e60f81e2b269d28334b73b70d02fb516c8de0c16242f5d376bfe6d94a3509f",
    strip_prefix = "rules_rust-58f709ffec90da93c4e622d8d94f0cd55cd2ef54",
    urls = [
        # Master branch as of 2021-02-04
        "https://github.com/bazelbuild/rules_rust/archive/58f709ffec90da93c4e622d8d94f0cd55cd2ef54.tar.gz",
    ],
)

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()
