## workspace 2:
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
blogs <- readLines("./data/en_US.blogs.txt", encoding = "UTF-8", skipNul = TRUE, warn = TRUE)
news <- readLines("./data/en_US.news.txt", encoding="UTF-8", skipNul = TRUE, warn = TRUE)
twitter <- readLines("./data/en_US.twitter.txt",encoding="UTF-8", skipNul = TRUE, warn = TRUE)

blogs_samp <- blogs[1:1000]
news_samp <- news[1:1000]
twitter_samp <- twitter[1:1000]
data <-as.data.frame(cbind(blogs_samp,news_samp,twitter_samp))
data <- pivot_longer(data, cols=1:3, names_to = "source_type", values_to = "text")
data$source_type <- as.factor(data$source_type)

# create data_frame of text examples/inputs/documents
data <- replace_contraction(data$text, sent.cap = FALSE)
data <- replace_ordinal(data)
data <- replace_number(data)
data <- replace_abbreviation(data)
data <- replace_symbol(data)
data <- gsub(pattern = "[[:space:]]*\\.+", replacement = "\\.", data)

data.tokens <- tokens(data, what = "sentence", remove_punct = FALSE, remove_numbers = TRUE,remove_symbols = TRUE, split_hyphens = TRUE)
data.tokens <- tokens_tolower(data.tokens)
data_sentances <- as.character(data.tokens)
data_sentances <- gsub(pattern = "\\.", replacement = "", data_sentances)
data_sentances <- gsub(pattern = "[^[:alnum:][:space:]'`]", replacement = "", data_sentances)

data.tokens <- tokens(data_sentances, what = "word")
data.tokens.dfm <- dfm(data.tokens)
unigram_freq <- textstat_frequency(data.tokens.dfm)[,1:2]
names(unigram_freq)[1] <- "text"
save(unigram_freq,file="./model_data/unigram.Rds")

bigram.tokens <- tokens_ngrams(data.tokens, n = 2)
bigram.dfm <- dfm(bigram.tokens)
bigram_freq <- textstat_frequency(bigram.dfm)[,1:2]
names(bigram_freq)[1] <- "text"
save(bigram_freq,file="./model_data/bigram.Rds")

trigram.tokens <- tokens_ngrams(data.tokens, n = 3)
trigram.dfm <- dfm(trigram.tokens)
trigram_freq <- textstat_frequency(trigram.dfm)[,1:2]
names(trigram_freq)[1] <- "text"
save(trigram_freq,file="./model_data/trigram.Rds")

quadgram.tokens <- tokens_ngrams(data.tokens, n = 4)
quadgram.dfm <- dfm(quadgram.tokens)
quadgram_freq <- textstat_frequency(quadgram.dfm)[,1:2]
names(quadgram_freq)[1] <- "text"
save(quadgram_freq,file="./model_data/quadgram.Rds")




