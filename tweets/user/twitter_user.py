import json
import sys 

data=open(sys.argv[1])

id=0
for line in data:
	#decode json into unicode
	user=json.loads(unicode(line,"ISO-8859-1"))
	name=user['name']
	follow=user['friends_count'] 
	follower=user['followers_count']
	if user['verified'] is True:
		verified=1
	else:
		verified=0
	if 'description' in user: 
		description=user['description']
	else:
		description=''
	print name.encode('utf-8')+'\t'+str(follow)+'\t'+str(follower)+'\t'+str(verified)+'\t'+description.encode('utf-8')