# y = "http://upload.wikimedia.org/wikipedia/commons/5/5d/AaronEckhart10TIFF.jpg"
# download.file(y,'y.jpg', mode = 'wb')
# 
# x = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.PQeiT3ofTb1v1tbGiso3wQAAAA%26pid%3DApi&f=1&ipt=b7b99137a632d39f85d126044a13177d32118b7dd68eaf4736b6b7df26be2480&ipo=images"
# download.file(x,'x.jpg', mode = 'wb')

urlList<- read.csv("player_image_urls.csv", stringsAsFactors = FALSE)
errors <- data.frame(player_id = c("Blank"), errMsg=c("Blank"))
warnings <- data.frame(player_id = c("Blank"), warnMsg=c("Blank"))
write.csv(errors, "error.csv", row.names = FALSE)
write.csv(warnings, "warnings.csv", row.names = FALSE)
for(element in 1:3081){
  tryCatch({
    url <- urlList$Updated_urls[element]
    imageName <- paste0("images/", urlList$Player_id[element], ".jpg")
    download.file(url,imageName, mode = 'wb')
    
  }, warning = function(warn) {
    print(paste("MY WARNING: ", warn))
    newWarn <- data.frame(player_id = c(urlList$Player_id[element]), 
                          warnMsg=c(paste("MY WARNING: ", warn)))
    write.csv(newWarn, "warnings.csv", row.names = FALSE, append = TRUE)
  }, error = function(err) {
    print(paste("MY ERROR: ", err))
    newError <- data.frame(player_id = c(urlList$Player_id[element]), 
                           errMsg=c(paste("MY ERROR: ", err)))
    write.csv(newError, "errors.csv", row.names = FALSE, append = TRUE)
  })
}