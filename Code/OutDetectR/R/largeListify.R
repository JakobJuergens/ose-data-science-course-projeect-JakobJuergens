#' This function is a convenience wrapper around largeList::saveList
#'
#'@param func_dat: list that contains the observations
#' each observation is a list, that contains two vectors of identical length: args and vals
#'@param path: path to where the file shall be saved, including a filename and the 
#' ending .llo
#'
#'@return Returns NULL.
#'@export
largeListify <- function(func_dat, path){
  tryCatch(
    {
      saveList(object = func_dat, file = path, append = FALSE, compress = FALSE)
    },
    error = function(cond){
      message('There was an Error saving the list.')
      message('Here is the original error message:')
      message(cond)
    },
    warning = function(cond){
      message('A warning was issued while saving.')
      message('Here is the original warning message:')
      message(cond)
    }
  )
  return(NULL)
}

#' This function is a convenience wrapper around largeList::saveList and is 
#' used to append a new observation to an existing largeList object
#'
#'@param func_obs: A new functional observation
#' each observation is a list, that contains two vectors of identical length: args and vals
#'@param path: path to where the file shall be saved, including a filename and the 
#' ending .llo
#'
#'@return Returns NULL.
#'@export
append_obs <- function(func_obs, path){
  tryCatch(
    {
      saveList(object = list(func_obs), file = path, append = TRUE, compress = FALSE)
    },
    error = function(cond){
      message('There was an Error while appending to the list.')
      message('Here is the original error message:')
      message(cond)
    },
    warning = function(cond){
      message('A warning was issued while appending to the list.')
      message('Here is the original warning message:')
      message(cond)
    }
  )
  
  return(NULL)
}