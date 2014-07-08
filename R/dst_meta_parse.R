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
#' @export
dst_meta_parse <- function(meta, lang){
  
  basics_names <- c("id", "text", "description", 
                    "unit", "updated", "footnote")
  
  basics <- meta[names(meta) %in% basics_names]
  
  variables <- meta[["variables"]][,c("id", "text")]
  
  values <- meta[["variables"]][,"values"]
  names(values) <- variables$id
  
  if(lang == "en"){
    test <- grepl(pattern="Tid", names(values))
    if(sum(test) > 0){
      values$Tid$id <- sub(pattern="Q", replacement="K", x=values$Tid$id)
    }
  }
  
  ## Create basic_query for the data_post file
  basic_query <- vector(mode="list", length=length(variables$id))
  names(basic_query) <- variables$id
  for(variable in 1:length(variables$id)){
    
    var_name <- variables$id[variable]
    
    if(var_name == "Tid"){
      basic_query[[var_name]] <- as.character(values[[var_name]]$id[length(values[[var_name]]$id)])
    } else {
      basic_query[[var_name]] <- as.character(values[[var_name]]$id[1])
    }
  }
  return(list("basics" = basics, "variables" = variables, "values" = values, "basic_query" = basic_query))
}
