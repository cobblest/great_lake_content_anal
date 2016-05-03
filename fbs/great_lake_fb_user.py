# First go to http://developers.facebook.com/tools/explorer
# make sure to get an access token and paste it in below
# This code prints items that I've liked.
 
import urllib
import json
import sys
import os

accessToken = 'CAACEdEose0cBACyIkyk1rYEMwtPaMCG6RuzafZCcf3yDfSTjIOqwzO4ZBLYJ8SynfcQkXUWbZCEvh6eGycGedlz4itvwiiGjj40lthiHd29yo07FYwqI0F8xXDgZA58NEV0VVt3ZAC3hmFzMB1rrLPqj8LTW9EHyV9bOEoRxiToiGbQcBNu1iZCopzXl7nRTWZAYNm9lSQfBQZDZD'  #INSERT YOUR ACCESS TOKEN
data=open('fblist.txt')

for userId in data:	
	userId=userId.strip()
	#print userId
	url='https://graph.facebook.com/'+userId+'/?field=about?access_token='+accessToken
	data = json.load(urllib.urlopen(url))
	name=data['name']
	if 'about' in data:
		about=data['about']
	else:
		about=''
	category=data['category']
	if 'website' in data:
		website=data['website']
	else:
		website=''
	link=data['link']
	talk=data['talking_about_count']
	here=data['were_here_count']
	like=data['likes']

	print name.encode('utf-8')+'\t'+link.encode('utf-8')+'\t'+about.encode('utf-8')+'\t'+category.encode('utf-8')+'\t'+website.encode('utf-8')+'\t'+str(talk)+'\t'+str(here)+'\t'+str(like)+'\t'