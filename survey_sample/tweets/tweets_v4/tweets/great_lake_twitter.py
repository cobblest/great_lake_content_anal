import json
import sys 

data=open(sys.argv[1])
id=0
for line in data:
	#decode json into unicode
	tweet=json.loads(unicode(line,"ISO-8859-1"))
	#parse text
	text=tweet['text'].encode('utf-8')
	#check if the tweet is a RT
	if text[0:2]=='RT':
		RT=1
	else:
		RT=0
	#check if the tweet is a MT
	if text[0:2]=='MT':
		MT=1
	else:
		MT=0
	#check if the tweet at someone
	words=text.split(' ')
	num_at=0
	for word in words:
		if len(word)!=0:
			if word[0]=='@':
				num_at+=1
	#parse other info
	retweet_count=tweet['retweet_count']
	favorite_count=tweet['favorite_count']
	time=tweet['created_at'][11:19]
	date=tweet['created_at'][4:10]
	year=tweet['created_at'][26:]
	num_hashtags=len(tweet['entities']['hashtags'])
	#check if there is a photo 
	if 'media' in tweet['entities']:
		photo=1
	else:
		photo=0
	#check if there is a link
	if len(tweet['entities']['urls'])==0:
		url=0
	else:
		url=1
	#check if the tweet is a reply
	reply=tweet['in_reply_to_user_id_str']
	if reply is None:
		num_reply=0
	else:
		num_reply=1
	id+=1
	print str(id).encode('utf-8')+'\t'+text+'\t'+time.encode('utf-8')+'\t'+date.encode('utf-8')+'\t'+str(year).encode('utf-8')+'\t'+str(retweet_count).encode('utf-8')+'\t'+str(favorite_count).encode('utf-8')+'\t'+str(num_hashtags).encode('utf-8')+'\t'+str(num_reply).encode('utf-8')+'\t'+str(RT).encode('utf-8')+'\t'+str(MT).encode('utf-8')+'\t'+str(num_at).encode('utf-8')+'\t'+str(photo).encode('utf-8')+'\t'+str(url).encode('utf-8')
	