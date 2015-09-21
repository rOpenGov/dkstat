#' This function parses the JSON from the StatBank.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)
#'
#' This function structures the JSON data a bit an creates a basic_query.
#' Some tables are VERY large, so the basic request is rather simple. The
#' function returns a list with basic data, info on available variables
#' and a list with a basic request.
#'
#' @param meta The returned meta data from the function meta_dst.
#' @param lang The language from the orignal dst_meta function (due to an error in the API)
dst_meta_parse <- function(meta, lang){
  
  # Get basic info on the table.
  # The basics contains a description on what
  # data the table contains, when it was updates and the units of the values.
  basics_names <- c("id", "text", "description", 
                    "unit", "updated", "footnote")
  basics <- meta[names(meta) %in% basics_names]
  
  # Get the description of the variables.
  # Keep the "elimination" columns as this describes if the variable
  # is mandatory or not.
  variables <- meta[["variables"]][,c("id", "text", "elimination")]
  
  # Structure the values the user can choose in their query
  values <- meta[["variables"]][,"values"]
  names(values) <- variables$id
  
  # Replace Q with K in the time as this is requiered by the API.
  # I'm not sure if this is a bug or an issue anymore but I keep the
  # fix just in case.
  if(lang == "en"){
    test <- grepl(pattern="Tid", names(values))
    if(sum(test) > 0){
      values$Tid$id <- sub(pattern="Q", replacement="K", x=values$Tid$id)
    }
  }
  
  # Return the data as a list.
  return(list("basics" = basics, "variables" = variables, "values" = values))
}
