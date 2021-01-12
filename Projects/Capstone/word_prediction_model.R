# word prediction model implementations and necessary functions:

load("./model_data/unigram.Rds")
load("./model_data/bigram.Rds")
load("./model_data/trigram.Rds")
load("./model_data/quadgram.Rds")
load("./model_data/bad_words.Rds")


check_for_valid_input <- function(input) return(grepl("^[a-zA-Z ]+$",input))

get_next_words_table <- function(sentance){
        phrase <- unlist(strsplit(sentance,' '))
        len_phrase <- length(phrase)
        return_phrases <- data.frame(text=character(),frequency=integer(),rel_prop=integer(),table=character(),stringsAsFactors=FALSE)
        if (len_phrase >= 3){
                phrase <- tail(phrase,3)
                phrase <- paste(phrase[1],phrase[2],phrase[3], sep='_')
                phrase <- paste0("^", phrase, "_")
                phrases <- quadgram_freq[grep(phrase, quadgram_freq$text),]
                phrases$rel_prob <- round(phrases$frequency/sum(phrases$frequency), digits = 4)
                #phrases$table <- rep("quadgram",length(phrases$rel_prob))
                return_phrases <- rbind(return_phrases,head(phrases,10))
                if (dim(return_phrases)[1] == 10) return(return_phrases)
        }
        if (len_phrase >= 2 & dim(return_phrases)[1] != 10){
                phrase <- unlist(strsplit(sentance,' '))
                phrase <- tail(phrase,2)
                phrase <- paste(phrase[1],phrase[2], sep='_')
                phrase <- paste0("^", phrase, "_")
                phrases <- trigram_freq[grep(phrase, trigram_freq$text),]
                phrases$rel_prob <- round(phrases$frequency/sum(phrases$frequency), digits = 4)
                #phrases$table <- rep("trigram",length(phrases$rel_prob))
                return_phrases <- rbind(return_phrases, head(phrases,10-dim(return_phrases)[1]))
                if (dim(return_phrases)[1] == 10) return(return_phrases)
        }
        if (len_phrase >= 1 & dim(return_phrases)[1] != 10){
                phrase <- unlist(strsplit(sentance,' '))
                phrase <- tail(phrase,1)
                phrase <- paste(phrase[1], sep='_')
                phrase <- paste0("^", phrase, "_")
                phrases <- bigram_freq[grep(phrase, bigram_freq$text),]
                phrases$rel_prob <- round(phrases$frequency/sum(phrases$frequency), digits = 4)
                #phrases$table <- rep("bigram",length(phrases$rel_prob))
                return_phrases <- rbind(return_phrases, head(phrases,10-dim(return_phrases)[1]))
                if (dim(return_phrases)[1] == 10) return(return_phrases)
        }
        if (len_phrase == 0 | dim(return_phrases)[1] != 10){
                phrases <- unigram_freq
                phrases$rel_prob <- round(phrases$frequency/sum(phrases$frequency), digits = 4)
                #phrases$table <- rep("unigram",length(phrases$rel_prob))
                return_phrases <- rbind(return_phrases, head(phrases,10-dim(return_phrases)[1]))
                return(return_phrases)
        }
}

remove_profanity_func <- function(sentance, bad_word_list = bad_words){
        phrase <- unlist(strsplit(sentance,'[[:space:]_]'))
        for (i in 1:length(phrase)){
                if (phrase[i] %in% bad_word_list) phrase[i] <- "****"
        }
        return(paste(phrase,collapse=" ") ) 
}

format_table <- function(table, print_full_table = FALSE, remove_profanity = FALSE){
        if (print_full_table) n <- 10 else n <- 1
        table_formatted <- table[1:n,]
        table_formatted$predicted_word <- character(length = n)
        for (i in 1:n) {
                if (remove_profanity) table_formatted$text[i] <- remove_profanity_func(table_formatted$text[i])
                table_formatted$text[i] <- gsub("[[:space:]_]"," ", table_formatted$text[i])
                table_formatted$predicted_word[i] <- tail(unlist(strsplit(table_formatted$text[i]," ")),1)
        } 
        names(table_formatted)[1] <- "phrase"
        table_formatted <- table_formatted[,c(4,1,2,3)]
        return(table_formatted)
}

#remove_profanity_func("this_fuck_you_bitch", bad_words)
#format_table(get_next_words_table("fuck this"),print_full_table = TRUE, remove_profanity = TRUE)














