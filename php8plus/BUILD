package(default_visibility = ["//visibility:public"])

load("//base:distro.bzl", "DISTRO_SUFFIXES")
load("//cc_php:extract_dependencies.bzl", "extract_dependencies")
load("//:checksums.bzl", "ARCHITECTURES")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer")
load("@php8plus_bundle_amd64_debian10//file:packages.bzl", extra_packages = "packages")
load(":php_paths.bzl", "PHP_EXT")
load("//php8:php-extensions.bzl", "php_extensions")

PHP_VERSION = "8.0"

EXCLUDED_DEBS = [
]

[
    container_image(
        name = ("php8plus" if (not mode) else mode[1:]) + "_" + user + "_" + arch + distro_suffix,
        architecture = arch,
        base = "//php8" + (mode if mode else ":php8") + "_" + user + "_" + arch + distro_suffix,
        debs = extract_dependencies(extra_packages, EXCLUDED_DEBS),
        symlinks = dict(php_extensions(PHP_EXT, PHP_VERSION).items()),
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
