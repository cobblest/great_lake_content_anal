import urllib
from bs4 import BeautifulSoup
import json
import sys 

content=urllib.urlopen('https://developers.facebook.com/tools/explorer?method=GET&path=EPAWatersense%2Ffeed%2F%3Flimit%3D100')
text = content.read()

for line in text:
	tweet=json.loads(line)
	text=tweet['title']
	print text
	
ss = text.split('<span class="userContent">')
for s in ss[1:]:
	end = s.find('</span>')
	msg = s[0:end]
	print msg

tt = text.split('<abbr title')
for t in tt[1:]:
	end = t.find('data-utime')
	postime=t[0:end]
	print postime
	
#Recent Posts by Others on YardMap
cc = text.split('<span class="messageBody" data-ft="&#123;&quot;type&quot;:3&#125;"><i class="tlPageStoryAttachment img sp_er534k sx_f5858a"></i>&nbsp;')
for c in cc[1:]:
	end = c.find('</span>')
	comment = c[0:end]
	print comment	
	
#html2text
#remove html tags
#soup = BeautifulSoup(text)
#content_html = soup.find("span",{"class":"userContent"})
#print content_html

#<span class="userContent">
#</span></div></div><div class="shareUnit">