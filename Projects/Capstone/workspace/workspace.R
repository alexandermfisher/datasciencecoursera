## workspace:
library(ggplot2)
library(NLP)
library(tm)
library(RWeka)
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(quanteda)

setwd("~/Documents/online_courses/data_science_specialisation/Projects/Capstone")

#Read in the appropriate data
news <- readLines("../data/en_US.news.txt", encoding="UTF-8", skipNul = TRUE, warn = TRUE)
twitter <- readLines("../data/en_US.twitter.txt",encoding="UTF-8", skipNul = TRUE, warn = TRUE)

#Sample the data
# set.seed(1130)
# samp_size = 500
# 
# news_samp <- news[sample(1:length(news),samp_size)]
# twitter_samp <- twitter[sample(1:length(twitter),samp_size)]

news_samp <- news[1:1000]
twitter_samp <- twitter[1:1000]

data <-as.data.frame(cbind(news_samp,twitter_samp))
data <- pivot_longer(data, cols=1:2, names_to = "source_type", values_to = "text")
data$source_type <- as.factor(data$source_type)
#rm(news,twitter)

# initial exploration:
prop.table(table(data$source_type))
data$text_length <- nchar(data$text)
summary(data$text_length)

# Visualize distribution with ggplot2, adding segmentation for ham/spam.
ggplot(data, aes(x = text_length, fill = source_type)) +
        theme_bw() +
        geom_histogram(binwidth = 5) +
        scale_x_continuous(limits = c(0, 500)) +
        labs(y = "Text Count", x = "Length of Text",
             title = "Distribution of Text Lengths with Source Types")




corp <- VCorpus(VectorSource(data[100,2]))

# Tokenize text from data:
data.tokens <- tokens(data$text, what = "word", 
                      remove_numbers = TRUE, remove_punct = FALSE,
                      remove_symbols = TRUE, split_hyphens = TRUE)
data.tokens <- tokens_tolower(data.tokens)
data.tokens <- tokens_remove(data.tokens, "[^[:alnum:][:space:].'`]",  valuetype = "regex")
#data.tokens <- tokens_replace(data.tokens, "[^[:alnum:][:space:].'`]", " ",  valuetype = "regex")
# not sure whether to stem words
#train.tokens <- tokens_wordstem(train.tokens, language = "english")

# Create our first bag-of-words model.
data.tokens.dfm <- dfm(data.tokens)
data.tokens.matrix <- as.matrix(data.tokens.dfm)
View(data.tokens.matrix[1:20, 1:100])
#n_words <- sum(data.tokens.matrix)

unigram_freq <- textstat_frequency(data.tokens.dfm, n = 20)[,1:2]
head(unigram_freq, 20)

bigram <- tokens_ngrams(data.tokens, n = 2)
bigram.dfm <- dfm(bigram)
bigram.matrix <- as.matrix(bigram.dfm)
bigram_freq <- textstat_frequency(bigram.dfm, n = 20)[,1:2]
tail(bigram_freq, 10)

trigram <- tokens_ngrams(data.tokens, n = 3)
trigram.dfm <- dfm(trigram)
trigram.matrix <- as.matrix(trigram.dfm)
trigram_freq <- textstat_frequency(trigram.dfm, n = 20)[,1:2]
head(trigram_freq)

multimodel 

multimodel <- tokens_ngrams(data.tokens, n = 1:3)
multimodel.dfm <- dfm(multimodel)
multimodel.matrix <- as.matrix(multimodel.dfm)
multimodel_freq <- textstat_frequency(multimodel.dfm)[,1:2]
tail(multimodel_freq)
































term.frequency <- function(doc) {doc/sum(doc)}
test1 <- t(apply(data.tokens.matrix, 1, term.frequency))
test1_freq <- create_ngrams_data_frame(test1)
test1_freq <- test1_freq[1:20, ]
test1_freq

tstat_freq <- textstat_frequency(data.tokens.dfm, n = 50)[,c(1,2,4)]
head(tstat_freq, 20)

topfeatures()

# toks_ngram <- tokens_ngrams(data.tokens, n = 2)
# head(toks_ngram[[1]], 30)
# toks_ngram.dfm <- dfm(toks_ngram)
# toks_ngram.matrix <- as.matrix(toks_ngram.dfm)

### Create Data Table of ngram and frequency:
create_ngrams_data_frame <- function(document_term_matrix) {
        frequencies <- colSums(document_term_matrix)
        ngrams <- data.frame(ngram = names(frequencies), frequency = frequencies, stringsAsFactors = FALSE)
        ngrams <- arrange(ngrams, desc(frequency))
        rownames(ngrams) <- 1:length(frequencies)
        return(ngrams)
}

one_grams <- create_ngrams_data_frame(data.tokens.matrix)
top_one_grams <- one_grams[1:50, ]
top_one_grams

two_ngrams <- create_ngrams_data_frame(toks_ngram.matrix)
top_two_ngrams <- two_ngrams[1:50, ]
top_two_ngrams




# ## example
# 
# replacePunctuation <- content_transformer(function(x) gsub("[^[:alnum:][:space:]'`]", " ", x))
# clean_corpus <- function(corpus) {
#         corpus <- tm_map(corpus, stripWhitespace)
#         corpus <- tm_map(corpus, replacePunctuation)
#         corpus <- tm_map(corpus, removeNumbers)
#         corpus <- tm_map(corpus, content_transformer(tolower))
#         corpus
# }
# 
# create_ngrams_data_frame <- function(document_term_matrix) {
#         frequencies <- colSums(document_term_matrix)
#         ngrams <- data.frame(ngram = names(frequencies), frequency = frequencies, stringsAsFactors = FALSE)
#         ngrams <- arrange(ngrams, desc(frequency))
#         rownames(ngrams) <- 1:length(frequencies)
#         return(ngrams)
# }
# 
# one_gram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
# 
# example <- clean_corpus(corp)
# document_term_matrix <- DocumentTermMatrix(example,control = list(tokenize = one_gram_tokenizer,wordLengths=c(1, Inf)))
# one_grams <- create_ngrams_data_frame(as.matrix(document_term_matrix))
# top_one_grams <- one_grams[1:50, ]
# top_one_grams










