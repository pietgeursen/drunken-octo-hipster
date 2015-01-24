def searchEmailForNumOccurances(fileToOpen, searchTerm, conversant1, conversant2)

	file = IO.read fileToOpen
	parts = file.partition "Content-Type: text/plain; charset=UTF-8"
	header = parts[0]

	bodyAndFooter = parts[2]
	parts = bodyAndFooter.partition "Content-Type:"
	body = parts[0]

	body = (body.partition "> wrote:")[0] #trim quoted text
	body = (body.partition "From:")[0] #trim quoted text

	if header.scan("From: " + conversant1).length > 0
		@sender = conversant1
	else
		@sender = conversant2
	end	

	body.scan(searchTerm).length

end

def processAllFilesInDirectory(directory, searchString, conversant1, conversant2)

	puts conversant1
	 
	score = {conversant1 => 0, conversant2 => 0}
	@sender = ''

	emails = Dir.glob(directory + '*.eml')
	emails.sort!

	emails.each do |email|	
		count = searchEmailForNumOccurances email, '!', conversant1, conversant2
		score[@sender] += count
		puts score[conversant1].to_s + ", " + score[conversant2].to_s
	end

end

processAllFilesInDirectory ARGV[0], ARGV[1], ARGV[2], ARGV[3]



