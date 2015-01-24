def searchEmailForNumOccurances(fileToOpen, searchTerm, conversant1, conversant2)

	file = IO.read fileToOpen
	parts = file.partition "Content-Type: text/plain; charset=UTF-8"
	header = parts[0]

	bodyAndFooter = parts[2]
	parts = bodyAndFooter.partition "Content-Type:"
	body = parts[0]

	body = (body.partition "> wrote:")[0] #trim quoted text
	body = (body.partition "From:")[0] #trim quoted text

	score = body.scan(searchTerm).length

	if header.scan("From: " + conversant1).length > 0
		sender = conversant1
	else
		sender = conversant2
	end		

	addToScore sender, score

end

def resetScore(conversant1, conversant2)
	@score = {conversant1 => 0, conversant2 => 0}
end

def addToScore(conversant, score)
	@score[conversant] += score
end

def printScore(conversant1, conversant2)
	puts @score[conversant1].to_s + ", " + @score[conversant2].to_s
end

def processAllFilesInDirectory(directory, searchString, conversant1, conversant2)

	resetScore conversant1, conversant2	 

	emails = Dir.glob(directory + '*.eml')
	emails.sort!

	emails.each do |email|	
		searchEmailForNumOccurances email, searchString, conversant1, conversant2		
		printScore conversant1, conversant2
	end

end

@score

processAllFilesInDirectory ARGV[0], ARGV[1], ARGV[2], ARGV[3]



