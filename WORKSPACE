workspace(name = "distroless")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "e0015762cdeb5a2a9c48f96fb079c6a98e001d44ec23ad4fa2ca27208c5be4fb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.24.14/rules_go-v0.24.14.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.24.14/rules_go-v0.24.14.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

# bazel_gazelle is used by rules_docker, and needs to be updated to override the very old version
# used in that workspace. We must use a version compatible with our version of rules_go. See:
# https://github.com/bazelbuild/bazel-gazelle#compatibility-with-rules-go
http_archive(
    name = "bazel_gazelle",
    sha256 = "222e49f034ca7a1d1231422cdb67066b885819885c356673cb1f72f748a3c9d4",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.3/bazel-gazelle-v0.22.3.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

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
        packages_url = "https://snapshot.debian.org/archive/debian-security/{}/dists/{}/updates/main/binary-{}/Packages.xz".format(DEBIAN_SECURITY_SNAPSHOT, distro, arch),
        sha256 = SHA256s[arch][name]["security"],
    )
    for arch in ARCHITECTURES
    for (name, distro) in VERSIONS
    if "debian10" == name
    if "security" in SHA256s[arch][name]
]

# debian11 has a slightly different structure for security on snapshots
[
    dpkg_src(
        name = arch + "_" + name + "_security",
        package_prefix = "https://snapshot.debian.org/archive/debian-security/{}/".format(DEBIAN_SECURITY_SNAPSHOT),
        packages_url = "https://snapshot.debian.org/archive/debian-security/{}/dists/{}-security/main/binary-{}/Packages.xz".format(DEBIAN_SECURITY_SNAPSHOT, distro, arch),
        sha256 = SHA256s[arch][name]["security"],
    )
    for arch in ARCHITECTURES
    for (name, distro) in VERSIONS
    if "debian11" == name
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
        name = "package_bundle_" + arch + "_debian11",
        packages = [
            "base-files",
            "ca-certificates",
            "libc6",
            "libc-bin",
            "libssl1.1",
            "netbase",
            "openssl",
            "tzdata",

            # c++
            "libgcc-s1",
            "libgomp1",
            "libstdc++6",
        ] + ([
            # python only builds on amd64/arm64
            "dash",
            "libbz2-1.0",
            "libcom-err2",
            "libcrypt1",  # TODO: glibc library for -lcrypt; maybe should be in cc?
            "libdb5.3",
            "libexpat1",
            "libffi7",
            "libgssapi-krb5-2",
            "libk5crypto3",
            "libkeyutils1",
            "libkrb5-3",
            "libkrb5support0",
            "liblzma5",
            "libmpdec3",
            "libncursesw6",
            "libnsl2",
            "libpython3.9-minimal",
            "libpython3.9-stdlib",
            "libreadline8",
            "libsqlite3-0",
            "libtinfo6",
            "libtirpc3",
            "libuuid1",
            "python3-distutils",
            "python3.9-minimal",
            "zlib1g",
            # java only builds on amd64/arm64
            "fontconfig-config",
            "fonts-dejavu-core",
            "libbrotli1",
            "libexpat1",
            "libfontconfig1",
            "libfreetype6",
            "libglib2.0-0",
            "libgraphite2-3",
            "libharfbuzz0b",
            "libjpeg62-turbo",
            "liblcms2-2",
            "libpcre3",
            "libpng16-16",
            "libuuid1",
            "openjdk-11-jdk-headless",
            "openjdk-11-jre-headless",
            "openjdk-17-jdk-headless",  # 11 and 17 should share the same "base"
            "openjdk-17-jre-headless",
            "zlib1g",
        ] if arch in BASE_ARCHITECTURES else []),
        sources = [
            "@" + arch + "_debian11_security//file:Packages.json",
            "@" + arch + "_debian11_updates//file:Packages.json",
            "@" + arch + "_debian11//file:Packages.json",
        ],
    )
    for arch in ARCHITECTURES
]

[
    dpkg_list(
        name = "package_bundle_" + arch + "_debian10",
        packages = [
            "libc6",
            "libc-bin",
            "base-files",
            "ca-certificates",
            "openssl",
            "libssl1.1",
            "libbz2-1.0",
            "libdb5.3",
            "libffi6",
            "liblzma5",
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
        ] + ([
            # python3 only builds on amd64/arm64
            "dash",
            "libexpat1",
            "libmpdec2",
            "libpython3.7-minimal",
            "libpython3.7-stdlib",
            "libtinfo6",
            "libuuid1",
            "libncursesw6",
            "python3-distutils",
            "python3.7-minimal",
            "zlib1g",
        ] if arch in BASE_ARCHITECTURES else []) + ([
            # java only builds on amd64
            "zlib1g",
            "libjpeg62-turbo",
            "libexpat1",
            "libpng16-16",
            "liblcms2-2",
            "libfreetype6",
            "fonts-dejavu-core",
            "fontconfig-config",
            "libfontconfig1",
            "libuuid1",
            "openjdk-11-jre-headless",
            "openjdk-11-jdk-headless",
            "libgraphite2-3",
            "libharfbuzz0b",
            "libglib2.0-0",
            "libpcre3",
            "zlib1g",
        ] if arch == "amd64" else []),
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
    sha256 = "01fae654b09932e446019aa859e7af6e05e27dbade12b54cd7bae3249fc723d9",
    strip_prefix = "jetty-distribution-9.4.43.v20210629/",
    type = "tar.gz",
    urls = ["https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.43.v20210629/jetty-distribution-9.4.43.v20210629.tar.gz"],
)

# Node (https://nodejs.org/en/about/releases/)
# Follow Node's maintainence schedule and support all LTS versions that are not end of life
http_archive(
    name = "nodejs12_amd64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "0c650e494a0ce293fb1220cc81ab5b6b819c249439c392b5ee2e8b812eec5592",
    strip_prefix = "node-v12.22.7-linux-x64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v12.22.7/node-v12.22.7-linux-x64.tar.gz"],
)

http_archive(
    name = "nodejs14_amd64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "83fa18a0e3642235446b66653eb27c169224ae9c1a15a32d6c3d9ddefb154ed4",
    strip_prefix = "node-v14.18.2-linux-x64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v14.18.2/node-v14.18.2-linux-x64.tar.gz"],
)

http_archive(
    name = "nodejs16_amd64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "5f80197d654fd0b749cdeddf1f07a5eac1fcf6b423a00ffc8f2d3bea9c6dc8d1",
    strip_prefix = "node-v16.13.1-linux-x64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-x64.tar.gz"],
)

http_archive(
    name = "nodejs12_arm64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "76fa99531cc57982e9a469babb03a7bd1c47d9392cb6d4b0d55f55858c4ed5a0",
    strip_prefix = "node-v12.22.7-linux-arm64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v12.22.7/node-v12.22.7-linux-arm64.tar.gz"],
)

http_archive(
    name = "nodejs14_arm64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "e78e18e01a08b2459d738fc5fec6bd79f2b3dccf85e5122cd646b3385964bc1e",
    strip_prefix = "node-v14.18.2-linux-arm64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v14.18.2/node-v14.18.2-linux-arm64.tar.gz"],
)

http_archive(
    name = "nodejs16_arm64",
    build_file = "//nodejs:BUILD.nodejs",
    sha256 = "c2f2a0a5adbfc267dbe41ef9fbd83af157a64997bc7546c12717ff55ea6b57d8",
    strip_prefix = "node-v16.13.1-linux-arm64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-arm64.tar.gz"],
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
    sha256 = "92779d3445e7bdc79b961030b996cb0c91820ade7ffa7edca69273f404b085d5",
    strip_prefix = "rules_docker-0.20.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.20.0/rules_docker-v0.20.0.tar.gz"],
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
