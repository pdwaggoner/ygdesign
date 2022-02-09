#' YouGov color palettes
#'
#' Use \code{\link{yg_palette}} to produce desired color palette
#'
#' @export
yg_palettes <- list(
  ps_core = c("#FF412C", "#9F29FF", "#FF2380", "#06A6EE", "#31CAA8"),
  secondary_core = c("#9F29FF", "#FF2380", "#06A6EE", "#31CAA8"),
  grapefruit = c("#FF8D80", "#FF6756", "#FF412C", "#E8281E", "#C20800"),
  plum = c("#C57FFF", "#B254FF", "#9F29FF", "#8001D8", "#6600AB"),
  pomegranate = c("#FF7BB3", "#FF4F99", "#FF2380", "#CD0E28", "#A50115"),
  blueberry = c("#6ACAF5", "#38B8F1", "#06A6EE", "#006BDB", "#003CAB"),
  avocado = c("#83DFCB", "#5AD5B9", "#31CAA8", "#149678", "#006B46"),
  full = c("#FF412C", "#9F29FF", "#FF2380", "#06A6EE", "#31CAA8", "#FFBA22", "#6600AB", "#FF7BB3",
           "#003CAB", "#83DFCB", "#C20800", "#C57FFF", "#FF8D80", "#6ACAF5", "#006B46", "#FF6756",
           "#8001D8", "#FF4F99", "#006BDB", "#5AD5B9", "#E8281E", "#B254FF", "#149678", "#FFE146"),
  grayscale = c("#F2F2F2", "#CCD1DB", "#B3BBC9", "#99A4B7", "#808DA5", "#616E90", "#33415C", "#000000")
)

#' YouGov color palette generator
#'
#' @usage yg_palette("name", n, "type")
#' @param n Number of colors to select from the palette. If null, then all colors in the palette are selected.
#' @param name Name of the specific palette in quotation marks.
#' @param type Specify the type of color mapping, either "continuous" or "discrete" in quotation marks. Use "continuous" to include more colors than those in the palette. See \code{examples} below for more.
#'   @importFrom graphics rgb rect par image text
#' @references Philip Waggoner. 2019. amerika: An American politics-inspired color palette generator. R package version 0.1.
#' @references Karthik Ram and Hadley Wickham. 2015. wesanderson: a Wes Anderson palette generator. R package version 0.3.
#' @return A vector of colors
#' @export
#' @examples
#' # Display each palette
#' yg_palette("ps_core")
#' yg_palette("secondary_core")
#' yg_palette("grapefruit")
#' yg_palette("plum")
#' yg_palette("pomegranate")
#' yg_palette("blueberry")
#' yg_palette("avocado")
#' yg_palette("full")
#' yg_palette("grayscale")
#'
#' # Interpolating between existing colors based on the palettes using the "continuous" type
#' yg_palette(50, name = "ps_core", type = "continuous")
#' yg_palette(50, name = "secondary_core", type = "continuous")
#' yg_palette(50, name = "grapefruit", type = "continuous")
#' yg_palette(50, name = "plum", type = "continuous")
#' yg_palette(50, name = "pomegranate", type = "continuous")
#' yg_palette(50, name = "blueberry", type = "continuous")
#' yg_palette(50, name = "avocado", type = "continuous")
#' yg_palette(50, name = "full", type = "continuous")
#' yg_palette(50, name = "grayscale", type = "continuous")

yg_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- yg_palettes[[name]]
  if (is.null(pal))
    stop("You supplied the name of a palette not included in 'ygdesign'.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("The number of requested colors is more than those offered by the palette.\n
         Consider changing the palette or the number of requested colors.")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(7, 0.15, 7, 0.15))
  on.exit(par(old))

  image(1:n, 1,
        as.matrix(1:n),
        col = x,
        xlab = "",
        ylab = "",
        xaxt = "n",
        yaxt = "n",
        bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "sans")
}
