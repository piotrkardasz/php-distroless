package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@php_package_bundle_amd64_debian10//file:packages.bzl", "packages")
load("//base:distro.bzl", "DISTRO_SUFFIXES")
load("//:php-checksums.bzl", "PHP_DISTRO_ARCHITECTURES")
load(":extract_dependencies.bzl", "extract_dependencies")

# An core image for PHP builds
[
    container_image(
        name = ("cc_php" if (not mode) else mode[1:]) + "_" + user + "_" + arch + distro_suffix,
        architecture = arch,
        base = "//cc" + (mode if mode else ":cc") + "_" + user + "_" + arch + distro_suffix,
        debs = extract_dependencies(packages),
    )
    for mode in [
        "",
        ":debug",
    ]
    for arch in PHP_DISTRO_ARCHITECTURES
    for user in [
        "root",
        "nonroot",
    ]
    for distro_suffix in DISTRO_SUFFIXES
]
