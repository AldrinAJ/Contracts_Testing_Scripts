import sys
import subprocess

Tools = ["oyente", "mythril", "manticore", "securify", "slither"]


def buildExec(contId, solidityName):
    scriptPath = "/app/Contracts_Testing_Scripts/scripts/" + contId + "/run.sh"
    dockerExec = "docker exec -it " + contId + " bash " + scriptPath + " " \
                 + solidityName + ".sol " + solidityName + ".out"
    return dockerExec


def main():
    if len(sys.argv) != 3:
        print("Usage: main.py [containerID] [solidityName]")
    else:
        contId = sys.argv[1]
        solidityName = sys.argv[2]
        dockerExec = buildExec(contId, solidityName)
        # print(dockerExec)

        # Executing the shell command
        print(dockerExec.split(" "))
        #subprocess.run(dockerExec.split(" "), shell=True, check=True)


if __name__ == "__main__":
    main()
