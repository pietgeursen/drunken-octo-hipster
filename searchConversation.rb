# Open a file and read from it
fileToOpen = 'GYB-GMail-Backup-pietgeursen@gmail.com/1-64454.eml'


def getNumOfOccurancesOfString(line, string)
	regex = Regexp::new(string)
	line.scan(regex).length 	
end

def checkSender(line, sender)
	getNumOfOccurancesOfString(line, 'From: '  + sender) > 0
end

def isEmailStart(line)
	checkSender(line, '') # finds first "From: "
end

def isEmailEnd(line)
	isEmailStart line
end

def scanForStartOfEmail(f)
	while !isEmailStart(f.gets)		
	end
	f
end

def processFile(fileToOpen)
	beginningOfEmail = false
	endOfEmail = false
	count = 0

	File.open(fileToOpen, 'r') do |f1| 

		f1 = scanForStartOfEmail f1

		while line = f1.gets
			count += getNumOfOccurancesOfString line, '!'
			if isEmailEnd(line)
				break
			end		
		end 
		f1.close
	end
	count 
end

dir = Dir.glob('GYB-GMail-Backup-pietgeursen@gmail.com/*.eml')
dir.sort!

dir.each {
	|eml_file|
	count = processFile(eml_file)
	puts eml_file
	puts count	
}
  # do work on files ending in .rb in the desired directory


