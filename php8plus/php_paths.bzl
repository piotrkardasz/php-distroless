# Dictionary that contains all the enabled extensions, their priorities and source paths
PHP_VERSION = "8.0"

PHP_EXT = {
    "xdebug": {
        "prio": "50",
        "path": "/etc/php/" + PHP_VERSION + "/mods-available/xdebug.ini",
    },
}
