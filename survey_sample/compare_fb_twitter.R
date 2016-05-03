t_n_p<-data.frame()
pval_n_p<-data.frame()
for (i in 1:16){
pval<-t.test(twitter_n_p[,i], fb_n_p[,i])$p.value
t<-t.test(twitter_n_p[,i], fb_n_p[,i])$statistic
pval_n_p<-rbind(pvalue_n_p,pval)
t_n_p<-rbind(t_n_p,t)
}

#select with same orgs
same_npo<-intersect(fb_nonprofit,twitter_nonprofit)
twitter_n_p_n<-twitter_n_p[match(same_npo, twitter_n_p$nonprofit),]
fb_n_p_n<-fb_n_p[match(same_npo, fb_n_p$nonprofit),]

#paired ttest
for (i in 1:16){
  pval<-t.test(twitter_n_p_n[,i], fb_n_p_n[,i],paired=TRUE, na.rm=TRUE)$p.value
  t<-t.test(twitter_n_p_n[,i], fb_n_p_n[,i],paired=TRUE, na.rm=TRUE)$statistic
  pval_n_p<-rbind(pval_n_p,pval)
  t_n_p<-rbind(t_n_p,t)
}
pval_n_p$codes<-codes
t_n_p$codes<-codes

#read in follower
wb_survey<-loadWorkbook("survey_data.xlsx")
data_survey <- readWorksheet(wb_survey, sheet = 5,endRow=32)
twitter_follower<-data_survey$Twitter.Follower[match(twitter_nonprofit,data_survey$uniqname)]
fb_follower<-data_survey$FB.like[match(fb_nonprofit,data_survey$uniqname)]
