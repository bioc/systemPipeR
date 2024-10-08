\name{plotWF}
\alias{plotWF}
\alias{plotwfOutput}
\alias{renderPlotwf}
\title{Visualize SPR workflow and status}

\description{
  Visualize SPR workflow and status. \code{plotWF} is the general function
  that creates the plot.
  \code{plotwfOutput} and \code{renderPlotwf} are used in Shiny UI and server
  respectively, similar to \code{plotOutput} and \code{renderPlot}.
}

\usage{
plotWF(
  sysargs,
  width = NULL, height = NULL,
  elementId = NULL,
  responsive = TRUE,
  branch_method = "auto",
  branch_no = NULL,
  layout = "compact",
  no_plot = FALSE,
  plot_method = "svg",
  out_format = "plot",
  out_path = NULL,
  show_legend = TRUE,
  mark_main_branch = FALSE,
  rstudio = FALSE,
  in_log = FALSE,
  rmarkdown = "detect",
  verbose = FALSE,
  show_warns = FALSE,
  plot_ctr = TRUE,
  pan_zoom = FALSE,
  exit_point = 0
)

plotwfOutput(
  outputId,
  width = '100\%',
  height = '400px'
)

renderPlotwf(
  expr,
  env = parent.frame(),
  quoted = FALSE
)
}
\arguments{
  \item{sysargs}{object of class \code{SYSargsList}.}

  \item{width}{string, a valid CSS string for width, like "500px", "100\%".}

  \item{height}{string, a valid CSS string for height, like "500px", "100\%".}

  \item{elementId}{string, optional ID value for the plot.}

  \item{responsive}{bool, should the plot be responsive? useful in Rstudio built-in
  viewer, Rmarkdown, Shiny or embed it into other web pages.}

  \item{branch_method}{string, one of "auto", "choose". How to determine the
  main branch of the workflow. "auto" will be determined by internal alrgothrim:
  Branches connecting the frist and last step and/or the longest will be favored.
  "choose" will list all possible branches and you can make a choice.}

  \item{branch_no}{numeric, only works if \code{branch_method == "choose"}. Specify a
  branch number to be the main branch instead of choosing from the prompt. This
  option can be good if you are in a non-interactive mode, e.g. rendering Rmd.}

  \item{layout}{string, one of "compact", "vertical", "horizontal", "execution".}

  \item{no_plot}{bool, if you want to assgin the plot to a variable and do not want
  to see it interactively, change this to \code{FALSE}.}

  \item{plot_method}{string, one of "svg", "png", how to make plot, use svg or png
  to embed the plot.}

  \item{out_format}{string, one of "plot", "html", "dot", "dot_print"
  \itemize{
    \item plot: directly open your viewer or browser of the plot
    \item html: save the plot to a html file
    \item dot: save the plot in DOT language, need a dot engine to remake the plot
    \item dot_print: directly cat the DOT code on console
  }
  See \code{details} section if one wish to generate other output format,
  such as \code{jpg} or \code{png}.
  }




  \item{out_path}{string, if the \code{out_format} is not "plot" or "dot_print",
  provide a path of where to save the plot.}

  \item{show_legend}{bool, show plot legend?}

  \item{mark_main_branch}{bool, color the main branch on the plot?}

  \item{rstudio}{bool, if you are using Rstudio, open the built-in viewer to see the
  plot? Default is no, open the browser tab to see it plot. The default viewer is
  too small to see the full plot clearly, so we recommend to use the browser tab.
  However, if you are using this plot in Shiny apps, always turn \code{rstudio = TRUE}.}

  \item{in_log}{bool, is this plot been made in a SPR log file? If \code{TRUE} will add
  links of steps to the corresponding log sections.}

  \item{rmarkdown}{are you rendering this plot in a Rmarkdown document? default value is
  "detect", this function will determine based on current R environment, or you
  can force it to be \code{TRUE} or \code{FALSE}.}

  \item{verbose}{bool, turn on verbose mode will give you more information.}

  \item{show_warns}{bool, print the warning messages on the plot?.}

  \item{plot_ctr}{bool, add the plot control panel to the plot? This requires you
  to have internet connection. It will download some additional javascript
  libraries, and allow you to save the plot as png, jpg, svg, pdf or graphviz
  directly from the browser.}

  \item{pan_zoom}{ bool, allow panning and zooming of the plot? Use mouse wheel
  or touch pad to zoom in and out of the plot. You need to have internet
  connection, additional javascript libraries will be loaded automatically online.
  Cannot be used with \code{responsive = TRUE} together. If both
  \code{TRUE}, \code{responsive} will be automatically set to \code{FALSE}.}

  \item{exit_point}{numeric, for advanced debugging only, see details}

  \item{outputId}{string, shiny output ID}

  \item{expr}{An expression that generates a plotwf, like \code{plotWF(sal)}}

  \item{env}{The environment in which to evaluate \code{expr}.}

  \item{quoted}{Is \code{expr} a quoted expression (with \code{quote()})?
This is useful if you want to save an expression in a variable.}
}
\value{
see \code{out_format} and \code{exit_point}
}

\details{
\subsection{layout}{
  \itemize{
  \item compact: try to plot steps as close as possible.
  \item vertical: main branch will be placed vertically and side branches will be placed
  on the same horizontal level and sub steps of side branches will be placed
  vertically.
  \item horizontal: main branch is placed horizontally and side branches and sub
  steps will be placed vertically.
  \item execution: a linear plot to show the workflow execution order of all steps.
}
}

\subsection{exit_point}{

return intermediate results at different points and exit the function
\itemize{
  \item 0: no early exit
  \item 1: after all branches are found, return tree
  \item 2: after the new tree has been built, return new nodes
  \item 3: after dot translation, return graph string
}
}

\subsection{Rmarkdown}{

Rmarkdown will change some of the format and cause conflicts. If the plot can be
rendered outside Rmd but cannot within Rmd, try to turn this option on. Some additional
javascript processing will be performed to avoid the conflict but may cause unknown
issues.
}

\subsection{Other output formats}{

The plot rendering uses \code{htmlwidgets}, which generates an interactive HTML page.
Saving these plots directly to standard image files, such as \code{png}, is not possible.
However, a few workarounds exist to save to these image formats:

\itemize{
  \item 1: use \code{webshot2::webshot} function.
  \item 2: use the interactive panel located on the top-left corner to download as an image
           after the plot is rendered.
  \item 3: use \code{plotWF(sal, plot_method = "png")} to embed the plot as \code{png}, and
           then right-click to save the image.
}

Please see our website for examples: https://systempipe.org/sp/spr/sp_run/step_vis/
}
\subsection{Shiny}{

When the plot is rendered in a Shiny app, the \code{rstudio} option must be turned on,
\code{plotWF(sal, rstudio = TRUE, ...)}.
}
}
