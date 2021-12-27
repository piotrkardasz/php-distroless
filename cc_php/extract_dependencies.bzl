def extract_dependencies(packages, excludedDeps = []):
    deps = []

    for (package) in packages:
        if package in excludedDeps:
            print("Excluded: {} package\n".format(package))
            continue
        else:
            deps.append(packages[package])
    return deps
