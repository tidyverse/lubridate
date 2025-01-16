#' @export
sum.Duration = function(..., na.rm = TRUE)
{
  purrr::reduce(
    .x = c(...),
    .f = `+`)
}
