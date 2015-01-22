This is a joke project to try and find the number of exclamation points in an email conversation.
The joke may not be funny to anyone but me.

I used "got your back" to get all the emails in a conversation. Got your back is at https://github.com/jay0lee/got-your-back/

To download a conversation run:

$ python gyb.py --email <your-email> --search <search-term> 

This gets you all the emails sorted into folders by date. I thought that was a bit annoying to code for later and wanted them all in one dir.

$ find ./  -name *.eml | xargs -I{} cp "{}" .


