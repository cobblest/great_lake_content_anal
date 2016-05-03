# First go to http://developers.facebook.com/tools/explorer
# make sure to get an access token and paste it in below
# This code prints items that I've liked.
 
import urllib
import json
import sys
import os

accessToken = 'CAACEdEose0cBAMQeVAFTYDwfEetONJk6aZBufW4FUU86cAV0qaxnyg6dP8tkN2KYqdUyRbTr6gqEvVXW4oYh9yVD4U3zZCoBWBi04xGANbAC2lWTwJXN1WaAewlrpKCuEc2aphwFqKZAYq08nyEOZBJtZAU1xDDNYDAcZA5fKmg7DdMJ6stFdDVsGMEmArf02z1yXZBunpdJNmzqtt05E7Se7UtTG7D1sAZD'  #INSERT YOUR ACCESS TOKEN
userId = sys.argv[1]          
limit=100

# Read my likes as a json object
url='https://graph.facebook.com/'+userId+'/feed?access_token='+accessToken +'&limit='+str(limit)
data = json.load(urllib.urlopen(url))
id=0

for item in data['data']:
	if 'message' in item:
		message=item['message']
	else:
		message=''
	message = os.linesep.join([s for s in message.splitlines() if s])
	#message=message.strip(' ') #trim ' \r\n\t'
	message= message.replace ('\n', '')
	from_id=item['from']['name']
	if 'story' in item:
		story=item['story']
	else:
		story=''
	story= story.replace ('\n', '')
	time=item['created_time'][11:19]
	date=item['created_time'][5:10]
	year=item['created_time'][0:4]
	if 'shares' in item:
		num_share=item['shares']['count']
	else:
		num_share=0
	if 'likes' in item:
		num_like=len(item['likes']['data'])
	else:
		num_like=0
	if 'comments' in item:
		num_comment=len(item['comments'])
	else:
		num_comment=0
	if 'picture' in item:
		picture=1
	else:
		picture=0
	if 'link' in item:
		link=1
	else:
		link=0
	id+=1
	#+str(num_like)+'\t'
	print str(id)+'\t'+message.encode('utf-8')+'\t'+story.encode('utf-8')+'\t'+from_id.encode('utf-8')+'\t'+time.encode('utf-8')+'\t'+date.encode('utf-8')+'\t'+year.encode('utf-8')+'\t'+str(num_share)+'\t'+str(num_like)+'\t'+str(num_comment)+'\t'+str(picture)+'\t'+str(link)