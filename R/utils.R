api_url <- function(){
  "https://hillcrestgeo.ca/"
}

user <- function(){
  user_agent("http://github.com/poissonconsulting/fwapgr")
}

fwa_api <- function(path, query) {

  chk_string(path)
  chk_list(query)
  chk_named(query)

  url <- modify_url(api_url(), path = path)
  resp <- GET(url, user(), query = query)

  chk_response_gateway(resp)
  # chk_response_json(resp)
  chk_response_status(resp)

  content(resp, "text", encoding = "UTF-8")
}

status_msg <- function(x){
  content(x, "text")
}

read_feature <- function(response, epsg){
  x <- sf::st_read(response, quiet = TRUE, stringsAsFactors = FALSE)
  # api default is 4326
  if(epsg == 4326)
    return(x)
  sf::st_transform(x, epsg)
}

format_parameter <- function(x){
  if(is.null(x)) return(x)
  paste(x, collapse = ",")
}

