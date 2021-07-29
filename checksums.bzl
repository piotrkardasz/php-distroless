# WARNING!!!
# DO NOT MODIFY THIS FILE DIRECTLY.
# TO GENERATE THIS RUN: ./updateWorkspaceSnapshots.sh

BASE_ARCHITECTURES = ["amd64", "arm64"]

# Exceptions:
# - s390x doesn't have libunwind8.
#   https://github.com/GoogleContainerTools/distroless/pull/612#issue-500157699
# - ppc64le doesn't have stretch security-channel.
#   https://github.com/GoogleContainerTools/distroless/pull/637#issuecomment-728139611
# - arm needs someone with available hardware to generate:
#   //experimental/python2.7/ld.so.arm.cache
ARCHITECTURES = BASE_ARCHITECTURES + ["arm", "s390x", "ppc64le"]

VERSIONS = [
    ("debian10", "buster"),
]

DEBIAN_SNAPSHOT = "20210729T144530Z"

DEBIAN_SECURITY_SNAPSHOT = "20210729T023407Z"

SHA256s = {
    "amd64": {
        "debian10": {
            "main": "cac8ec1569eb723def822f5b44cd6b0c159062af7f3d138d662ee734298f88aa",
            "updates": "b3759d1c539914be5553a925c7f10a8726819ff9637400f6b334d8ae3a1117da",
            "security": "b9215f1d70262dac75e0d6782bd7b346fc3193b1f8e5bb93d4ab3794c1bdca9a",
        },
    },
    "arm": {
        "debian10": {
            "main": "1a971c6a8dd807e476c26705ebb56eeb4be4f626d67654085cc27b5241e6d7f7",
            "updates": "0dbc70e6bcb7e6f8753e0f5dc2df00c79b584b26870b405127e02dcde18b723b",
            "security": "662602c6d1260d495c1d3c941a579ac9e87783325ce12befee416b396313e9a5",
        },
    },
    "arm64": {
        "debian10": {
            "main": "764700430a2e940aed47f91c19ea767b47945b082faec0610952a2f400bc7a3b",
            "updates": "677f4154256ef1edd3091eb24bba7c8fc3f7c564effad705f68eb1d4cd17bd82",
            "security": "0f998f1ef5ab426cd005d331b6d276a274516cd7133bc98e94096dd02d2d61e9",
        },
    },
    "s390x": {
        "debian10": {
            "main": "faaa3f0282c888ac0ceaa4c28a0d39355df99477fadbbc3f78d2c11808082721",
            "updates": "45a5e37dc68bfd2d248bf99267242a293fd13b9f56e857d2bbd560a8378ee428",
            "security": "ba7298d430c24d400d3abf528b1ba5c6689db8f91cc766687d8be8e641f143f4",
        },
    },
    "ppc64le": {
        "debian10": {
            "main": "0321fc30f8277db65e80313b11eee0d0f8c9aa48adf0a670bb6826cd3cdefdaf",
            "updates": "be0d6353263b069fda7a3cef92f11e3783db3af3dfa8c825c1ed7672dc86ae9c",
            "security": "f3ca900bcb7d861eae28ec812a0cafe3fb1120ea4df37aeda6dbcc2e29f6bd69",
        },
    },
}
