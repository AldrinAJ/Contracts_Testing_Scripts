import sys

if len(sys.argv) != 3:
	print "Usage: main.py containerID solidityName"
else:
	contId = "mythril"
	solidityName = "1_oyente"
	scriptPath = "/app/Contracts_Testing_Scripts/scripts/" + contId + "/run.sh"
	docker_exec = "docker exec -it " + contId + " bash " + scriptPath + " " + solidityName + ".sol " + solidityName + ".out"

	print docker_exec
