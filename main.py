import sys
import os

Tools = ["oyente", "mythril", "manticore", "securify", "slither"]


def buildExec(contId, solidityName):
    scriptPath = "/app/Contracts_Testing_Scripts/scripts/" + contId + "/run.sh"
    dockerExec = "docker exec -it " + contId + " bash " + scriptPath + " " \
                 + solidityName + ".sol " + solidityName + ".out"
    return dockerExec


def main():
    if len(sys.argv) == 3:
        if (sys.argv[1] == "cfg"):
            print ("build cfg...")
            solidityName = sys.argv[2]
            buildcfgExec = "docker exec -it " + "slither" + " bash " + "/app/Contracts_Testing_Scripts/scripts/buildcfg/run.sh" + " " + "/app/Contracts_Testing/results/cfgs/research/" + solidityName + ".sol"
            os.system(buildcfgExec)

        else:
            contId = sys.argv[1]
            # without ext
            solidityName = sys.argv[2] + "_" + contId
            dockerExec = buildExec(contId, solidityName)
            # Executing the shell command
            os.system(dockerExec)

    else:
        print("Usage: main.py <-i> [containerID]+ [targetLevel]")


if __name__ == "__main__":
    main()
