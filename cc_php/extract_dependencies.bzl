def extract_dependencies(packages):
    deps = []

    for (package) in packages:
        deps.append(packages[package])
    return deps
