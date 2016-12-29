import subprocess

def runCommand(command):
	return subprocess.Popen(["bash", "-c", command], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

def execute():
	output = runCommand("time clisp Main.lsp").communicate()
	#userTime plus system Time
	return float(output[1].split('\n')[1].split('m')[1][:-1]) + float(output[1].split('\n')[2].split('m')[1][:-1])

totalTime = 0
minTime = 0

for j in range(0, 100):
	
	executeTime = 0.0000
	for i in range(0, 1000):
		executeTime += execute()
	
	totalTime += executeTime
	print "Iteration: " , j , "\tTotal time for 1000 Lisp executions: " + "{0:.10f}".format(executeTime) + "s\tTotal run time: ", totalTime,"s"
	
	if j == 0 or minTime > executeTime:
	    minTime = executeTime;
	
print "Average Lisp time: " "{0:.10f}".format(totalTime/100)
print "Min Lisp time: " "{0:.10f}".format(minTime)