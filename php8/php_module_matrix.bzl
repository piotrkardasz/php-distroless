def php_module_matrix(php_versions, modules):
    packages = []

    for php_version in php_versions:
        packages.append("php" + php_version)
        if php_version == "7.4":
            packages.append("php" + php_version + "-json")
        for module in modules:
            packages.append("php" + php_version + "-" + module)

    return packages
