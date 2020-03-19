skip_if_cant_set_s4_names <- function() {
  skip_if(getRversion() < "3.5.0", message = "Can't set names on an S4 object")
}
