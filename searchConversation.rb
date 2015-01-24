def getNumOfOccurancesOfString(line, string)	
	line.scan(string).length 
end

def checkSender(line, sender)
	getNumOfOccurancesOfString(line, 'From: '  + sender) > 0
end

def searchEmailForNumOccurances(fileToOpen, searchTerm)

	file = IO.read fileToOpen
	parts = file.partition "Content-Type: text/plain; charset=UTF-8"
	header = parts[0]

	bodyAndFooter = parts[2]
	parts = bodyAndFooter.partition "Content-Type:"
	body = parts[0]

	body = (body.partition "> wrote:")[0] #trim quoted text
	body = (body.partition "From:")[0] #trim quoted text

	if checkSender(header,  'Piet')
		@sender = "Piet"
	else
		@sender = "Babs"
	end	

	body.scan(searchTerm).length

end

def processAllFilesInDirectory
	score = {"Piet" => 0, "Babs" => 0}
	@sender = ''

	emails = Dir.glob('GYB-GMail-Backup-pietgeursen@gmail.com/*.eml')
	emails.sort!

	emails.each do |email|	
		count = searchEmailForNumOccurances email, '!'
		score[@sender] += count
		puts score["Piet"].to_s + ", " + score["Babs"].to_s
	end

end

processAllFilesInDirectory



