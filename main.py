import sys


def main():
    if len(sys.argv) != 3:
        print("Usage: main.py containerID solidityName")
    else:
        contId = sys.argv[1]
        solidityName = sys.argv[2]
        scriptPath = "/app/Contracts_Testing_Scripts/scripts/" + contId + "/run.sh"
        dockerExec = "docker exec -it " + contId + " bash " + scriptPath + " " + solidityName + ".sol " + solidityName + ".out"
        print(dockerExec)


if __name__ == "__main__":
    main()
