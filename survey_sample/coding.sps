/*Facebook data

RECODE Category ('edu'='1') ('media'='2') ('news'='3') ('press'='4') ('tools'='5') ('website'='6') 
    ('conversation'='7') ('other site'='8') ('recognition and thank'='9') ('report of event '='10') 
    ('advocacy '='11') ('call for action '='12') ('event '='13') ('raise fund '='14') ('recruiting '+
    ''='15') ('special day '='16').
EXECUTE.

RECODE Category (1=1) (ElSE=0) INTO edu.
RECODE Category (2=1) (ElSE=0) INTO media.
RECODE Category (3=1) (ElSE=0) INTO news.
RECODE Category (4=1) (ElSE=0) INTO press.
RECODE Category (5=1) (ElSE=0) INTO tools.
RECODE Category (6=1) (ElSE=0) INTO website.
RECODE Category (7=1) (ElSE=0) INTO conversation.
RECODE Category (8=1) (ElSE=0) INTO other_site.
RECODE Category (9=1) (ElSE=0) INTO recognition_and_thank.
RECODE Category (10=1) (ElSE=0) INTO report_of_event.
RECODE Category (11=1) (ElSE=0) INTO advocacy.
RECODE Category (12=1) (ElSE=0) INTO call_for_action.
RECODE Category (13=1) (ElSE=0) INTO event.
RECODE Category (14=1) (ElSE=0) INTO raise_fund.
RECODE Category (15=1) (ElSE=0) INTO recruiting.
RECODE Category (16=1) (ElSE=0) INTO special_day.
EXECUTE.

RECODE Type (1=1) (ElSE=0) INTO Information.
RECODE Type (2=1) (ElSE=0) INTO Community.
RECODE Type (3=1) (ElSE=0) INTO Action.
EXECUTE.

MEANS TABLES=normFBshare normFBlike normFBcomment BY category type
  /CELLS MEAN COUNT STDDEV SEMEAN.

ONEWAY normFBshare normFBlike normFBcomment BY Category
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /POSTHOC=LSD ALPHA(0.05).

ONEWAY normFBshare normFBlike normFBcomment BY type
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /POSTHOC=LSD ALPHA(0.05).

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normFBshare
  /METHOD=ENTER edu media news press tools website conversation other_site recognition_and_thank 
    report_of_event advocacy call_for_action event raise_fund recruiting special_day picture link.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normFBlike
  /METHOD=ENTER edu media news press tools website conversation other_site recognition_and_thank 
    report_of_event advocacy call_for_action event raise_fund recruiting special_day picture link.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normFBcomment
  /METHOD=ENTER edu media news press tools website conversation other_site recognition_and_thank 
    report_of_event advocacy call_for_action event raise_fund recruiting special_day picture link.

/*Facebook three types regression

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normFBshare
  /METHOD=ENTER Information Community Action picture link.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normFBlike
  /METHOD=ENTER Information Community Action picture link.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normFBcomment
  /METHOD=ENTER Information Community Action picture link.

/*Twitter data

MEANS TABLES=normretweet normfavorite BY Category Type
  /CELLS MEAN COUNT STDDEV SEMEAN.

ONEWAY normretweet normfavorite BY type
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /POSTHOC=LSD ALPHA(0.05).

ONEWAY normretweet normfavorite BY Category
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /POSTHOC=LSD ALPHA(0.05).

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normretweet
  /METHOD=ENTER hashtags reply @ photo link edu media news press tools website conversation 
    other_site recognition_and_thank report_of_event advocacy call_for_action event raise_fund recruiting special_day.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normfavorite
  /METHOD=ENTER hashtags reply @ photo link edu media news press tools website conversation 
    other_site recognition_and_thank report_of_event advocacy call_for_action event raise_fund recruiting special_day.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normretweet
  /METHOD=ENTER hashtags reply @ photo link Information Community Action.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normfavorite
  /METHOD=ENTER hashtags reply @ photo link Information Community Action.

