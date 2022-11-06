package(default_visibility = ["//visibility:public"])

load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("//base:distro.bzl", DISTROS = "LANGUAGE_DISTROS")
load("//base:base.bzl", "NONROOT", "deb_file")
load("//:checksums.bzl", ARCHITECTURES = "BASE_ARCHITECTURES")
load(":php_core_libs.bzl", "php_core_libs")
load(":php_extensions.bzl", "php_extensions")
load(":php_module_matrix.bzl", "php_module_matrix")
load(":php_paths.bzl", "php_binary", "php_config")
load(":php_version_dependencies.bzl", "php_version_dependencies")
load(":php_versions.bzl", "PHP_VERSIONS")

APP_DIR = "/var/www"

WWW_DATA = 33

passwd_entry(
    name = "www-data_user",
    gid = WWW_DATA,
    home = "/www",
    info = "www-data",
    shell = "/sbin/nologin",
    uid = WWW_DATA,
    username = "www-data",
)

passwd_file(
    name = "passwd",
    entries = [
        "//base:root_user",
        "//base:nobody_user",
        "//base:nonroot_user",
        ":www-data_user",
    ],
)

pkg_tar(
    name = "passwd_tar",
    srcs = [":passwd"],
    mode = "0644",
    package_dir = "etc",
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
        "//base:root_group",
        "//base:nobody_group",
        "//base:tty_group",
        "//base:staff_group",
        "//base:nonroot_group",
        ":www-data_group",
    ],
)

pkg_tar(
    name = "group_tar",
    srcs = [":group"],
    mode = "0644",
    package_dir = "etc",
)

[
    pkg_tar(
        name = user + "_project_empty_dirs_tar",
        empty_dirs = [
            APP_DIR,
        ],
        mode = "755",
        owner = str(user_id) + "." + str(user_id),
    )
    for (user, user_id) in [
        ("root", 0),
        ("nonroot", NONROOT),
    ]
]

[
    container_layer(
        name = "php" + php_version + "_dirs",
        empty_dirs = [
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

container_layer(
    name = "php_pid",
    empty_dirs = ["/run/php/"],
    mode = "1733",
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
        name = "php" + php_version + ("" if (not mode) else mode) + "_" + user + "_" + arch + "_" + distro,
        architecture = arch,
        base = ("//cc:cc" if (not ("debug" in mode)) else "//cc:debug") + "_" + user + "_" + arch + "_" + distro,
        debs = php_module_matrix(
            arch,
            distro,
            php_version,
            [
                "apcu",
                "cli",
                "common",
                "curl",
                "dev",
                "fpm",
                "gd",
                "intl",
                "mbstring",
                "mcrypt",
                "mysql",
                "opcache",
                "readline",
                "xml",
                "zip",
            ],
        ) + [
        ] + php_core_libs(
            arch,
            distro,
        ),
        entrypoint = [
            "/usr/sbin/php-fpm",
            "-F",
            "-O",
        ],
        env = {
            "LANG": "C.UTF-8",
            "PHP_VERSION": php_version,
            "ARCHITECTURE": arch,
            "distro": distro + "- distroless",
            "LINUX_USER": user,
            "DEFAULT_WORKDIR": APP_DIR,
        },
        layers = [
            "php_pid",
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
        tags = [
            arch,
            "manual",
        ],
        tars = [
            ":passwd_tar",
            ":group_tar",
            ":php" + php_version + "_fpm_www_pool",
            ":" + user + "_project_empty_dirs_tar",
        ],
        workdir = APP_DIR,
    )
    for mode in [
        "",
        "_debug",
    ]
    for arch in ARCHITECTURES
    for user in [
        "root",
        "nonroot",
    ]
    for distro in DISTROS
    for php_version in PHP_VERSIONS
]

[
    container_test(
        name = "php" + php_version + ("" if (not mode) else mode) + "_" + user + "_" + arch + "_" + distro + "_test",
        configs = ["testdata/php" + php_version + "_" + user + "_" + distro + ".yaml"],
        image = ":php" + php_version + ("" if (not mode) else mode) + "_" + user + "_" + arch + "_" + distro,
        tags = [
            arch,
            "manual",
        ],
    )
    for mode in [
        "",
        "_debug",
    ]
    for arch in ARCHITECTURES
    for user in [
        "root",
        "nonroot",
    ]
    for distro in DISTROS
    for php_version in PHP_VERSIONS
]
