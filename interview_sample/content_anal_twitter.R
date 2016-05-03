#packages
install.packages("gdata")
library(gdata)
install.packages("xlsx")
library(xlsx)
install.packages("rJava")
library(rJava)

#work dir
setwd("~/Dropbox/Research/Great Lake 2013/Content_anal/interview_sample/tweets_interview")
setwd("F:/study/YY/Dropbox/Research/Great Lake 2013/Content_anal/interview_sample/tweets_interview")

#create data frame
twitter.all<-data.frame()
twitter_n<-data.frame()
twitter_n_p<-data.frame()
twitter_retweet<-data.frame()
twitter_hashtag<-data.frame()
twitter_favorite<-data.frame()
twitter_N<-data.frame()
twitter_photo<-data.frame()
twitter_link<-data.frame()
twitter_reply<-data.frame()
#twitter_nonprofit<-sheetNames("twitter_coding.xlsx") 
codes<-c("education/tools","media","news","special day","website/organization update","conversation","recognition and thanks","other organization","reporter",
         "live tweeting","call for action","event","fundraising","advocacy","social media campaign")
#codes<-c("education/tools","media","news","website/organization update","conversation","recognition and thank","other organization","call for action","event","fundraising","advocacy")

#install.packages("RODBC")
#require(RODBC) 
#channel <- odbcConnectExcel("twitter_coding.xlsx") 


##load all coding data
data<-read.xls("twitter_coding.xlsx",sheet=1,header=TRUE)
for (i in 1:20){
  data.all<-rbind(data.all,read.xls("twitter_coding.xlsx",sheet=i,header=FALSE))
}
names(data.all)<-names(data)
data.all<-data.all[which(data.all$Code %in% codes),]

#regression analysis
data.all$RT<-factor(data.all$RT)
data.all$Reply<-factor(data.all$Reply)
data.all$MT<-factor(data.all$MT)
data.all$photo<-factor(data.all$photo)
data.all$link<-factor(data.all$link)
data.all$Code<-factor(data.all$Code)
twitter.all$Hashtags<-as.numeric(twitter.all$Hashtags)
twitter.all$at<-as.numeric(twitter.all$at)
data.all$Retweet<-as.numeric(data.all$Retweet)
data.all$Favorite<-as.numeric(data.all$Favorite)
fit <- lm(Retweet ~ Code +Hashtags + Reply + RT + at + photo + link, data=twitter.all)
fit <- lm(Retweet ~ Hashtags + Reply + RT + at + photo + link, data=twitter.all)
summary(fit) # show results
fit <- lm(Favorite ~ Code +Hashtags + Reply + RT + at + photo + link, data=twitter.all)
summary(fit) # show results

##for each individual organization
for (i in 1:20){
  data<-read.xls("twitter_coding.xlsx",sheet=i,header=TRUE)
  data<-data[which(data$Code %in% codes),]
  data.all<-rbind(data.all,data)
  #summary(data)
  #calculate how many posts and average share,like and comment
  n_code<-sapply(codes, function(x) length(which(data$Code==x)))
  N=sum(n_code)
  n_code_p<-n_code/N
  n_retweet<-sapply(codes, function(x) sum(as.numeric(paste(data$Retweet[which(data$Code==x)])))/n_code[which(codes==x)])
  n_favorite<-sapply(codes, function(x) sum(as.numeric(paste(data$Favorite[which(data$Code==x)])))/n_code[which(codes==x)])
  n_hashtag<-sapply(codes, function(x) sum(as.numeric(paste(data$Hashtags[which(data$Code==x)])))/n_code[which(codes==x)])
  n_photo<-length(which(data$photo==1))
  n_link<-length(which(data$link==1))
  n_reply<-length(which(data$Reply==1))
    
  twitter_n<-rbind(twitter_n,n_code)
  twitter_n_p<-rbind(twitter_n_p,n_code_p)
  twitter_retweet<-rbind(twitter_retweet,n_retweet)
  twitter_favorite<-rbind(twitter_favorite,n_favorite)
  twitter_hashtag<-rbind(twitter_hashtag,n_hashtag)
  twitter_N<-rbind(twitter_N,N)
  twitter_photo<-rbind(twitter_photo,n_photo)
  twitter_link<-rbind(twitter_link,n_link)
  twitter_reply<-rbind(twitter_reply,n_reply)
  #twitter_nonprofit<-c(twitter_nonprofit,as.character(data$nonprofit[1]))
}
names(twitter_n)<-codes
names(twitter_n_p)<-codes
twitter_n$id<-c(1:nrow(twitter_n))
names(twitter_retweet)<-codes
twitter_retweet$id<-c(1:nrow(twitter_n))
twitter_retweet$nonprofit<-twitter_nonprofit[1:20]
names(twitter_favorite)<-codes
twitter_favorite$id<-c(1:nrow(twitter_n))
twitter_favorite$nonprofit<-twitter_nonprofit[1:20]
names(twitter_hashtag)<-codes
twitter_hashtag$id<-c(1:nrow(twitter_n))
twitter_hashtag$nonprofit<-twitter_nonprofit[1:20]

#calculate proportion of codings
colSums(twitter_n)/sum(twitter_n)
690*colSums(twitter_n)/sum(twitter_n) 

#number of 
boxplot(twitter_n[,c(1:4)]) #information
boxplot(twitter_n[,c(5:7)]) #community
boxplot(twitter_n[,c(7:11)]) #action
boxplot(twitter_retweet[,c(1:15)]) #likes
boxplot(twitter_favorite[,c(1:15)]) #likes
boxplot(twitter_hashtag[,c(1:15)]) #likes

#export table
write.csv(twitter_retweet,file="twitter_retweet.csv")
write.csv(twitter_favorite,file="twitter_favorite.csv")
write.csv(twitter_hashtag,file="twitter_hashtag.csv")

#group into three big groups
m_twitter_retweet_info <- melt(twitter_retweet[,c(1:5,16)], id=c("id"))
summary(m_twitter_retweet_info)
m_twitter_retweet_comm <- melt(twitter_retweet[,c(6:10,16)], id=c("id"))
summary(m_twitter_retweet_comm)
m_twitter_retweet_action <- melt(twitter_retweet[,c(11:15,16)], id=c("id"))
summary(m_twitter_retweet_action)

m_twitter_favorite_info <- melt(twitter_favorite[,c(1:5,16)], id=c("id"))
summary(m_twitter_favorite_info)
m_twitter_favorite_comm <- melt(twitter_favorite[,c(6:10,16)], id=c("id"))
summary(m_twitter_favorite_comm)
m_twitter_favorite_action <- melt(twitter_favorite[,c(11:15,16)], id=c("id"))
summary(m_twitter_favorite_action)

m_twitter_hashtag_info <- melt(twitter_hashtag[,c(1:5,16)], id=c("id"))
summary(m_twitter_hashtag_info)
m_twitter_hashtag_comm <- melt(twitter_hashtag[,c(6:10,16)], id=c("id"))
summary(m_twitter_hashtag_comm)
m_twitter_hashtag_action <- melt(twitter_hashtag[,c(11:15,16)], id=c("id"))
summary(m_twitter_hashtag_action)


install.packages("reshape")
library(reshape)
m <- reshape::melt(fb_n,id.vars = "id") 
cast(m, id~...)
se=sd(m$value)/sqrt(length(m$value))

install.packages("pastecs")
library(pastecs)

install.packages("ggplot2")
library(ggplot2)
ggplot(m, aes(x=variable, y=value)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=value-se, ymax=value+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

fb_m<-m
names(fb_m)[2]<-"coding"
names(fb_m)[3]<-"n"

m <- reshape::melt(fb_share) 
cast(m, id~...) 

