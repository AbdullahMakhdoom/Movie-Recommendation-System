recommendation_model <- recommenderRegistry$get_entries(dataType = "realRatingMatrix")
names(recommendation_model)

lapply(recommendation_model, "[[", "description")

#Implementing Item-Based Collaborative Filtering
recommendation_model$IBCF_realRatingMatrix$parameters

similarity_mat <- similarity(ratingMatrix[1:4, ],
                             method = "cosine",
                             which = "users")
as.matrix(similarity_mat)

image(as.matrix(similarity_mat), main = "User's Similarities")

movie_similarity <- similarity(ratingMatrix[, 1:4], method = "cosine",
                               which = "items")
as.matrix(movie_similarity)
image(as.matrix(movie_similarity), main="Movies similarity")

rating_values <- as.vector(ratingMatrix@data)
unique(rating_values) #extracting unique ratings

Table_of_Ratings <- table(rating_values) # creating a count of movie ratings
Table_of_Ratings

# Visualization of Most Watched Movies
library(ggplot2)
movie_views <- colCounts(ratingMatrix) # count views for each movie
table_views <- data.frame(movie = names(movie_views),
                          views = movie_views) # create dataframe of views
table_views <- table_views[order(table_views$views,
                                 decreasing = TRUE), ] # sort by number of views
table_views$title <- NA
for (index in 1:10325){
  table_views[index,3] <- as.character(subset(movie_data,
                                              movie_data$movieId == 
                                                table_views[index,1])$title)
}

table_views[1:6,]

ggplot(table_views[1:6, ], aes(x = title, y = views)) +
  geom_bar(stat="identity", fill = 'steelblue') +
  geom_text(aes(label=views), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Total Views of the Top Films")

# Heatmap of Movie Ratings
image(ratingMatrix[1:20, 1:25], axes = FALSE, 
      main = "Heatmap of the first 25 rows and 25 columns")




