#Building the next word prediction

#Load the n-gram databases 

load=("bigram.Rds")
load=("trigram.Rds")
load=("quadgram.Rds")

#Load the necessary libraries
library(stringr)
library(dplyr)
library(tm)
#library(stylo)

proc1 <- function(sentence){
        
        a <- unigramlist$unigram
        
        return(as.String(a[10]))
}
proc <- function(sentence){
        value = "And the prediction is..."
        sen = unlist(strsplit(sentence,' '))
        if(length(sen)>=3){
                value = quadgram(sen[(length(sen)-2):length(sen)])
        }
        
        if(is.null(value)||length(sen)==2){
                value = trigram(sen[(length(sen)-1):length(sen)])
                
        }
        if(is.null(value)||length(sen)==1){
                value = bigram(sen[length(sen)])
                
        }
        if(is.null(value)){
                value = "the"
        }
        
        return(value)
}

quadgram <- function(fourg){
        four <- paste(fourg,collapse = ' ')
        foursum <- data.frame(fourgram="test",frequency=0)
        k <- trigramlist[trigram==four]
        m <- as.numeric(k$frequency)
        if(length(m)==0) return(NULL)
        
        for(string0 in unigramlist$unigram){
                text = paste(four,string0)
                found <- quadgramlist[quadgram==text]
                n<- as.numeric(found$frequency)
                
                if(length(n)!=0){
                        foursum <- rbind(foursum,found)
                        
                }
        }
        if(nrow(foursum)==1) return(NULL)
        foursum <- foursum[order(-frequency)]
        sen <- unlist(strsplit(as.String(foursum[1,quadgram]),' '))
        return (sen[length(sen)])
}

trigram <- function(threeg){
        three <- paste(threeg,collapse = ' ')
        threesum <- data.frame(trigram="test",frequency=0)
        k <- bigramlist[bigram==three]
        m <- as.numeric(k$frequency)
        if(length(m)==0) return(NULL)
        
        for(string0 in unigramlist$unigram){
                text = paste(three,string0)
                found <- trigramlist[trigram==text]
                n<- as.numeric(found$frequency)
                
                if(length(n)!=0){
                        threesum <- rbind(threesum,found)
                        
                }
        }
        if(nrow(threesum)==1) return(NULL)
        threesum <- threesum[order(-frequency)]
        sen <- unlist(strsplit(as.String(threesum[1,trigram]),' '))
        return (sen[length(sen)])
}

bigram <- function(twog){
        two <- paste(twog,collapse = ' ')
        twosum <- data.frame(bigram="test",frequency=0)
        print(nrow(unigramlist))
        k <- unigramlist[unigram==two]
        m <- as.numeric(k$frequency)
        if(length(m)==0) return(NULL)
        
        for(string0 in unigramlist$unigram){
                text = paste(two,string0)
                found <- bigramlist[bigram==text]
                n<- as.numeric(found$frequency)
                
                if(length(n)!=0){
                        twosum <- rbind(twosum,found)
                        
                }
        }
        
        if(nrow(twosum)==1) return(NULL)
        twosum <- twosum[order(-frequency)]
        
        sen <- unlist(strsplit(as.String(twosum[1,bigram]),' '))
        return (sen[length(sen)])
}