def php_matrix(php_versions):
    packages = []

    for php_version in php_versions:
        packages.append("php" + php_version)

    return packages
