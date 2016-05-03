setwd("~/Dropbox/Research/Great Lake 2013/Content_anal/interview_sample/fbs_interview")
setwd("F:/study/YY/Dropbox/Research/Great Lake 2013/Content_anal/interview_sample/fbs_interview")
install.packages("gdata")
library(gdata)
fb.all<-data.frame()
fb_n<-data.frame()
fb_n_p<-data.frame()
fb_share<-data.frame()
fb_like<-data.frame()
fb_comment<-data.frame()
fb_N<-data.frame()
fb_photo<-data.frame()
fb_link<-data.frame()
fb_nonprofit<-c()
codes<-c("education/tools","media","news","special day","website/organization update","conversation","recognition and thank","other organization","reporter",
         "live tweeting","call for action","event","fundraising","advocacy","social media campaign")
#codes<-c("education/tools","media","news","website/organization update","conversation","recognition and thank","other organization","call for action","event","fundraising","advocacy")

#load all fb posts
data<-read.xls("facebook_coding.xlsx",sheet=1,header=TRUE)
for (i in 1:23){
  fb.all<-rbind(fb.all,read.xls("facebook_coding.xlsx",sheet=i,header=FALSE))
}
names(fb.all)<-names(data)
fb.all<-fb.all[which(fb.all$code %in% codes),]

#regression analysis
fb.all$picture<-factor(fb.all$picture)
fb.all$link<-factor(fb.all$link)
fb.all$code<-factor(fb.all$code)
fb.all$share<-as.numeric(fb.all$share)
fb.all$like<-as.numeric(fb.all$like)
fb.all$comment<-as.numeric(fb.all$comment)

#regression analysis
fit <- lm(share ~ code + picture + link, data=fb.all)
summary(fit)
fit <- lm(like ~ code + picture + link, data=fb.all)
summary(fit) 
fit <- lm(comment ~ code + picture + link, data=fb.all)
summary(fit) 

#load each individual orgs
for (i in 1:23){
data<-read.xls("facebook_coding.xlsx",sheet=i,header=TRUE,row.names=NULL)
data<-data[which(data$code %in% codes),]
summary(data)

#calculate how many posts and average share,like and comment
n_code<-sapply(codes, function(x) length(which(data$code==x)))
N=sum(n_code)
n_code_p<-n_code/N
n_share<-sapply(codes, function(x) sum(as.numeric(paste(data$share[which(data$code==x)])))/n_code[which(codes==x)])
n_like<-sapply(codes, function(x) sum(as.numeric(paste(data$like[which(data$code==x)])))/n_code[which(codes==x)])
n_comment<-sapply(codes, function(x) sum(as.numeric(paste(data$comment[which(data$code==x)])))/n_code[which(codes==x)])
n_photo<-length(which(data$picture==1))
n_link<-length(which(data$link==1))

fb_n<-rbind(fb_n,n_code)
fb_n_p<-rbind(fb_n_p,n_code_p)
fb_share<-rbind(fb_share,n_share)
fb_like<-rbind(fb_like,n_like)
fb_comment<-rbind(fb_comment,n_comment)
fb_N<-rbind(fb_N,N)
fb_photo<-rbind(fb_photo,n_photo)
fb_link<-rbind(fb_link,n_link)
fb_nonprofit<-c(fb_nonprofit,as.character(data$nonprofit[1]))
}
names(fb_n)<-codes
names(fb_n_p)<-codes
#fb_n$id<-c(1:nrow(fb_n))
names(fb_share)<-codes
fb_share$id<-c(1:nrow(fb_n))
fb_share$nonprofit<-fb_nonprofit
names(fb_like)<-codes
fb_like$id<-c(1:nrow(fb_n))
fb_like$nonprofit<-fb_nonprofit
names(fb_comment)<-codes
fb_comment$id<-c(1:nrow(fb_n))
fb_comment$nonprofit<-fb_nonprofit

#export table
write.csv(fb_share,file="fb_share.csv")
write.csv(fb_like,file="fb_like.csv")
write.csv(fb_comment,file="fb_comment.csv")

#proportion of diff category
colSums(fb_n)/sum(fb_n)
690*colSums(fb_n)/sum(fb_n) 

#boxplot of different category
boxplot(fb_n[,c(1:4)]) #information
boxplot(fb_n[,c(5:7)]) #community
boxplot(fb_n[,c(9:12)]) #action
par(cex.axis=0.5) #font size
boxplot(fb_share) #likes
boxplot(fb_like) #likes
boxplot(fb_comment[,c(1;15)]) #likes

#group into three big groups
m_fb_share_info <- melt(fb_share[,c(1:5,16)], id=c("id"))
summary(m_fb_share_info)
m_fb_share_comm <- melt(fb_share[,c(6:10,16)], id=c("id"))
summary(m_fb_share_comm)
m_fb_share_action <- melt(fb_share[,c(11:15,16)], id=c("id"))
summary(m_fb_share_action)

m_fb_like_info <- melt(fb_like[,c(1:5,16)], id=c("id"))
summary(m_fb_like_info)
m_fb_like_comm <- melt(fb_like[,c(6:10,16)], id=c("id"))
summary(m_fb_like_comm)
m_fb_like_action <- melt(fb_like[,c(11:15,16)], id=c("id"))
summary(m_fb_like_action)

m_fb_comment_info <- melt(fb_comment[,c(1:5,16)], id=c("id"))
summary(m_fb_comment_info)
m_fb_comment_comm <- melt(fb_comment[,c(6:10,16)], id=c("id"))
summary(m_fb_comment_comm)
m_fb_comment_action <- melt(fb_comment[,c(11:15,16)], id=c("id"))
summary(m_fb_comment_action)

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

#number of likes, etc.

