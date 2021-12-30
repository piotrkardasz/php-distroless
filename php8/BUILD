package(default_visibility = ["//visibility:public"])

load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("@php8_bundle_amd64_debian10//file:packages.bzl", "packages")
load("//base:distro.bzl", "DISTRO_SUFFIXES")
load(":php_paths.bzl", "php_binary", "php_config")
load(":php-extensions.bzl", "php_extensions")
load("//:php-checksums.bzl", "PHP_DISTRO_BASE_ARCHITECTURES", "PHP_VERSIONS")
load(":php_version_dependencies.bzl", "php_version_dependencies")

# www-data user UID
WWW_DATA = 33

[
    container_layer(
        name = "php" + php_version + "_dirs",
        empty_dirs = [
            "/run/php",
            "/srv/sylius",
            "/var/lib/php/modules/" + php_version + "/registry",
        ],
        mode = "755",
    )
    for php_version in PHP_VERSIONS
]

container_layer(
    name = "php_sessions",
    empty_dirs = ["/var/lib/php/sessions"],
    # We set sticky bit so others can write and execute on the dir
    # but not reading or deleting others files
    mode = "1733",
)

passwd_entry(
    name = "www-data_user",
    gid = WWW_DATA,
    home = "/var/www",
    info = "www-data",
    uid = WWW_DATA,
    username = "www-data",
)

passwd_file(
    name = "passwd",
    entries = [
        ":www-data_user",
    ],
)

group_entry(
    name = "www-data_group",
    gid = WWW_DATA,
    groupname = "www-data",
    users = ["www-data"],
)

group_file(
    name = "group",
    entries = [
        ":www-data_group",
    ],
)

pkg_tar(
    name = "passwd_tar",
    srcs = [":passwd"],
    mode = "0644",
    package_dir = "etc",
)

pkg_tar(
    name = "group_tar",
    srcs = [":group"],
    mode = "0644",
    package_dir = "etc",
)

[
    pkg_tar(
        name = "php" + php_version + "_fpm_www_pool",
        srcs = ["conf/zz-www.conf"],
        mode = "0644",
        package_dir = "etc/php/" + php_version + "/fpm/pool.d/",
    )
    for php_version in PHP_VERSIONS
]

[
    container_image(
        name = "php" + php_version + ("" if (not mode) else mode) + "_" + user + "_" + arch + distro_suffix,
        architecture = arch,
        base = ("//cc_php:cc_php" if (not ("debug" in mode)) else "//cc_php:debug") + "_" + user + "_" + arch + distro_suffix,
        debs = php_version_dependencies(packages, php_version),
        entrypoint = [
            "/usr/sbin/php-fpm",
            "-F",
            "-O",
        ],
        env = {
            "LANG": "C.UTF-8",
            "PHP_VERSION": php_version,
            "ARCHITECTURE": arch,
            "distro": distro_suffix + "- distroless",
        },
        layers = [
            "php" + php_version + "_dirs",
            "php_sessions",
        ],
        ports = ["9000"],
        symlinks = dict(
            php_extensions(
                php_config(php_version),
                php_version,
            ).items() +
            php_binary(php_version).items(),
        ),
        tars = [
            ":passwd_tar",
            ":group_tar",
            ":php" + php_version + "_fpm_www_pool",
        ],
        workdir = "/srv/sylius",
    )
    for mode in [
        "",
        "_debug",
    ]
    for arch in PHP_DISTRO_BASE_ARCHITECTURES
    for user in [
        "root",
        "nonroot",
    ]
    for distro_suffix in DISTRO_SUFFIXES
    for php_version in PHP_VERSIONS
]

[
    container_test(
        name = "php" + php_version + "_debug_root_amd64_debian10_test",
        size = "medium",
        configs = ["testdata/php" + php_version + "_debian10.yaml"],
        image = ":php" + php_version + "_root_amd64_debian10",
    )
    for php_version in PHP_VERSIONS
]
