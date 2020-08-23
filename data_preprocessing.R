movie_genre <- as.data.frame(movie_data$genres, stringsAsFactors=FALSE)
library(data.table)
movie_genre2 <- as.data.frame(tstrsplit(movie_genre[,1], '[|]', 
                                        type.convert=TRUE), 
                              stringsAsFactors=FALSE)

colnames(movie_genre2) <- c(1:10)
list_genre <- c("Action", "Adventure", "Animation", "Children", 
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                "Film-Noir", "Horror", "Musical", "Mystery","Romance",
                "Sci-Fi", "Thriller", "War", "Western")
genre_mat1 <- matrix(0,10330,18)
genre_mat1[1,] <- list_genre
colnames(genre_mat1) <- list_genre

for(index in 1:nrow(movie_genre2)){
  for(col in 1:ncol(movie_genre2)){
    gen_col = which(genre_mat1[1,] == movie_genre2[index,col])
    genre_mat1[index+1, gen_col] <- 1
  }
}

genre_mat2 <- as.data.frame(genre_mat1[-1,], #remove first row,
                            stringsAsFactors = FALSE) #which was the genre list

for(col in 1:ncol(genre_mat2)){
  genre_mat2[,col] <- as.integer(genre_mat2[,col])
}
str(genre_mat2)

SearchMatrix <- cbind(movie_data[,1:2], genre_mat2[])
head(SearchMatrix)

ratingMatrix <- dcast(rating_data, userId~movieId, value.var = "rating",
                          na.rm = FALSE)
ratingMatrix <- as.matrix(ratingMatrix[,-1])
ratingMatrix <- as(ratingMatrix, "realRatingMatrix")
ratingMatrix 

