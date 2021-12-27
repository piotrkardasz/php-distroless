# Dictionary that contains all the enabled extensions, their priorities and source paths
PHP_VERSION = "8.0"

PHP_EXT = {
    "calendar": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/calendar.ini",
    },
    "ctype": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/ctype.ini",
    },
    "dom": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-xml/xml/dom.ini",
    },
    "exif": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/exif.ini",
    },
    "fileinfo": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/fileinfo.ini",
    },
    "ftp": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/ftp.ini",
    },
    "gd": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-gd/gd/gd.ini",
    },
    "gettext": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/gettext.ini",
    },
    "iconv": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/iconv.ini",
    },
    "json": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-json/json/json.ini",
    },
    "mbstring": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-mbstring/mbstring/mbstring.ini",
    },
    "mysqlnd": {
        "prio": "10",
        "path": "/usr/share/php" + PHP_VERSION + "-mysql/mysql/mysqlnd.ini",
    },
    "opcache": {
        "prio": "10",
        "path": "/usr/share/php" + PHP_VERSION + "-opcache/opcache/opcache.ini",
    },
    "pdo_mysql": {
        "prio": "10",
        "path": "/usr/share/php" + PHP_VERSION + "-mysql/mysql/pdo_mysql.ini",
    },
    "pdo": {
        "prio": "10",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/pdo.ini",
    },
    "phar": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/phar.ini",
    },
    "posix": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/posix.ini",
    },
    "readline": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-readline/readline/readline.ini",
    },
    "shmop": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/shmop.ini",
    },
    "simplexml": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-xml/xml/simplexml.ini",
    },
    "sockets": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/sockets.ini",
    },
    "sysvmsg": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/sysvmsg.ini",
    },
    "sysvsem": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/sysvsem.ini",
    },
    "sysvshm": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/sysvshm.ini",
    },
    "tokenizer": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-common/common/tokenizer.ini",
    },
    "wddx": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-xml/xml/wddx.ini",
    },
    "xml": {
        "prio": "15",
        "path": "/usr/share/php" + PHP_VERSION + "-xml/xml/xml.ini",
    },
    "xmlreader": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-xml/xml/xmlreader.ini",
    },
    "xmlwriter": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-xml/xml/xmlwriter.ini",
    },
    "xsl": {
        "prio": "20",
        "path": "/usr/share/php" + PHP_VERSION + "-xml/xml/xsl.ini",
    },
}

PHP_LINKS = {
    "/usr/bin/php": "/usr/bin/php" + PHP_VERSION,
    "/usr/sbin/php-fpm": "/usr/sbin/php-fpm" + PHP_VERSION,
}
