

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
	isEmailStart(line) || (getNumOfOccurancesOfString(line, '> wrote:') > 0) || (getNumOfOccurancesOfString(line, 'Content-Type: text/html;') > 0) 
end

def scanForStartOfEmail(f)
	
	while (line = f.gets)
		if isEmailStart(line)
			if checkSender(line,  'Piet')
				puts "Piet"
			else
				puts "Babs"
			end

			break
		end
	end
	
	f
end

def processFile(fileToOpen)

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
	#puts eml_file
	puts count	
}
  # do work on files ending in .rb in the desired directory


