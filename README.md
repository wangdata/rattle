# rattle
  **Rattle** (the R Analytic Tool To Learn Easily) provides a Gnome (RGtk2) based interface to R functionality for **data mining**. This repository includes slides of the book *Data Mining with Rattle and R (2011)*, written by **Graham Williams**. Slides were coded by Latex and knitr.

  **Data mining** is the art and science of intelligent data analysis. The aim is to discover meaningful insights and knowledge from **data**. Discoveries are often expressed as **models**, and we often describe data mining as the process of building models. A model captures, in some formulation, the essence of the discovered knowledge. A model can be used to assist in our **understanding** of the world. Models can also be used to make **predictions**.
  
## Installing rattle
  If you already have R installed and have installed the appropriate **GTK** libraries for your operating system, then installing rattle is as simple as:
```{r eval=FALSE, echo=TRUE}
install.packages("rattle")
```

## Starting rattle
```{r eval=FALSE, echo=TRUE}
library(rattle)
```

### Starting rattle GUI
```{r eval=FALSE, echo=TRUE}
rattle()
```

  The rattle user interface is a simple tab-based interface, with the idea being to work from the leftmost tab to the rightmost tab, mimicking the typical data mining process.
