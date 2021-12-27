# Dictionary that contains all the enabled extensions, their priorities and source paths
PHP_VERSION = "7.4"

PHP_EXT = {
    "igbinary": {
        "prio": "25",
        "path": "/etc/php/" + PHP_VERSION + "/mods-available/igbinary.ini",
    },
    "redis": {
        "prio": "30",
        "path": "/etc/php/" + PHP_VERSION + "/mods-available/redis.ini",
    },
    "apcu": {
        "prio": "20",
        "path": "/etc/php/" + PHP_VERSION + "/mods-available/apcu.ini",
    },
    "xdebug": {
        "prio": "50",
        "path": "/etc/php/" + PHP_VERSION + "/mods-available/xdebug.ini",
    },
}
