def getNumOfOccurancesOfString(line, string)
	regex = Regexp::new(string)
	
	line.scan(regex).length 
	# puts line
	# puts string
	# line.to_s.count string	

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
				@sender = "Piet"
			else
				@sender = "Babs"
			end

			break
		end
	end
	
	f
end

def searchEmailForNumOccurances(fileToOpen, searchTerm)

	numOccurances = 0

	File.open(fileToOpen, 'r') do |file| 

		file = scanForStartOfEmail file

		while line = file.gets
			numOccurances += getNumOfOccurancesOfString line, searchTerm
			if isEmailEnd(line)
				break
			end		
		end 
		file.close
	end
	numOccurances 
end


def processAllFilesInDirectory
	score = {"Piet" => 0, "Babs" => 0}
	@sender = ''


	emails = Dir.glob('GYB-GMail-Backup-pietgeursen@gmail.com/*.eml')
	emails.sort!

	emails.each do |email|
		count = searchEmailForNumOccurances(email, '!')

		score[@sender] += count
	#puts email
	puts score["Piet"].to_s + ", " + score["Babs"].to_s	
	end
end

#processAllFilesInDirectory



