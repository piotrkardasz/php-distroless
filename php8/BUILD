package(default_visibility = ["//visibility:public"])

load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("@php8_bundle_amd64_debian10//file:packages.bzl", "packages")
load("//base:distro.bzl", "DISTRO_SUFFIXES")
load("//cc_php:extract_dependencies.bzl", "extract_dependencies")
load("//:checksums.bzl", "ARCHITECTURES")
load(":php_paths.bzl", "PHP_EXT", "PHP_LINKS")
load(":php-extensions.bzl", "php_extensions")

PHP_VERSION = "8.0"

# www-data user UID
WWW_DATA = 33

container_layer(
    name = "php_dirs",
    empty_dirs = [
        "/run/php",
        "/srv/sylius",
        "/var/lib/php/modules/" + PHP_VERSION + "/registry",
    ],
    mode = "755",
)

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

pkg_tar(
    name = "php_fpm_www_pool",
    srcs = ["conf/zz-www.conf"],
    mode = "0644",
    package_dir = "etc/php/" + PHP_VERSION + "/fpm/pool.d/",
)

[
    container_image(
        name = ("php8" if (not mode) else mode[1:]) + "_" + user + "_" + arch + distro_suffix,
        architecture = arch,
        base = "//cc_php" + (mode if mode else ":cc_php") + "_" + user + "_" + arch + distro_suffix,
        debs = extract_dependencies(packages),
        entrypoint = [
            "/usr/sbin/php-fpm",
            "-F",
            "-O",
        ],
        env = {"LANG": "C.UTF-8"},
        layers = [
            "php_dirs",
            "php_sessions",
        ],
        ports = ["9000"],
        symlinks = dict(php_extensions(PHP_EXT, PHP_VERSION).items() + PHP_LINKS.items()),
        tars = [
            ":passwd_tar",
            ":group_tar",
            ":php_fpm_www_pool",
        ],
        workdir = "/srv/sylius",
    )
    for mode in [
        "",
        ":debug",
    ]
    for arch in ARCHITECTURES
    for user in [
        "root",
        "nonroot",
    ]
    for distro_suffix in DISTRO_SUFFIXES
]

container_test(
    name = "php-fpm_test",
    size = "medium",
    configs = ["testdata/debian10.yaml"],
    image = ":php8_root_amd64_debian10",
)
