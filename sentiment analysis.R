data <- read.csv(file.choose(), header = T) #file = ytdata1
dim(data)
str(data) #stucture data

#Sentiment analysis
# install.packages('syuzhet')
library(syuzhet)
comment <- iconv(data$Comment, to = 'utf-8')

#Obtain sentiment score
s <- get_nrc_sentiment(comment)
head(s)
dim(s)

#Create new column (neutral) (if column positive + negative = 0, column neutral = 1)
s$neutral <- ifelse(s$negative+s$positive==0, 1, 0)
head(s)
sum(s)
colSums(s)
100*colSums(s)/sum(s)
# write.csv(s, 'sentiment ytdata1.csv',row.names = F)

#Create a list to store each comment with its sentiment analysis
comment_sentiments <- list()
for (i in 1:length(comment)) {
  comment_sentiments[[i]] <- list(
    comment = comment[i],
    sentiment = get_nrc_sentiment(comment[i])
  )
}

#Display the sentiment analysis
comment_sentiments[[1]] # 1 to 229 comment

#Barplot
barplot(100*colSums(s)/sum(s),
        las = 2,
        col = rainbow(11),
        ylab = 'Percentage',
        main = 'Sentiment Score from watercolors Painting Demonstration')
