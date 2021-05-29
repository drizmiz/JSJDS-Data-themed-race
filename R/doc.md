---
title: "说明"
author: drizzle
documentclass: ctexart
output:
  rticles::ctex:
    fig_caption: yes
    number_sections: yes
    toc: no

    keep_md: yes
    keep_tex: yes
geometry: left=2cm, right=2cm, top=2.5cm, bottom=2.5cm
monofont: Fira Mono
---

// TODO




```r
session_info(pkgs = c("tidyverse", "lubridate"))
```

```
## - Session info ---------------------------------------------------------------
##  setting  value                       
##  version  R version 4.1.0 (2021-05-18)
##  os       Ubuntu 20.04.2 LTS          
##  system   x86_64, linux-gnu           
##  ui       X11                         
##  language zh_CN:zh                    
##  collate  zh_CN.UTF-8                 
##  ctype    zh_CN.UTF-8                 
##  tz       Asia/Shanghai               
##  date     2021-05-29                  
## 
## - Packages -------------------------------------------------------------------
##  package       * version  date       lib source        
##  askpass         1.1      2019-01-13 [1] CRAN (R 4.1.0)
##  assertthat      0.2.1    2019-03-21 [1] CRAN (R 4.1.0)
##  backports       1.2.1    2020-12-09 [1] CRAN (R 4.1.0)
##  base64enc       0.1-3    2015-07-28 [1] CRAN (R 4.1.0)
##  BH              1.75.0-0 2021-01-11 [1] CRAN (R 4.1.0)
##  blob            1.2.1    2020-01-20 [1] CRAN (R 4.1.0)
##  broom           0.7.6    2021-04-05 [1] CRAN (R 4.1.0)
##  callr           3.7.0    2021-04-20 [1] CRAN (R 4.1.0)
##  cellranger      1.1.0    2016-07-27 [1] CRAN (R 4.1.0)
##  cli             2.5.0    2021-04-26 [1] CRAN (R 4.1.0)
##  clipr           0.7.1    2020-10-08 [1] CRAN (R 4.1.0)
##  colorspace      2.0-1    2021-05-04 [1] CRAN (R 4.1.0)
##  cpp11           0.2.7    2021-03-29 [1] CRAN (R 4.1.0)
##  crayon          1.4.1    2021-02-08 [1] CRAN (R 4.1.0)
##  curl            4.3.1    2021-04-30 [1] CRAN (R 4.1.0)
##  data.table      1.14.0   2021-02-21 [1] CRAN (R 4.1.0)
##  DBI             1.1.1    2021-01-15 [1] CRAN (R 4.1.0)
##  dbplyr          2.1.1    2021-04-06 [1] CRAN (R 4.1.0)
##  digest          0.6.27   2020-10-24 [1] CRAN (R 4.1.0)
##  dplyr         * 1.0.6    2021-05-05 [1] CRAN (R 4.1.0)
##  dtplyr          1.1.0    2021-02-20 [1] CRAN (R 4.1.0)
##  ellipsis        0.3.2    2021-04-29 [1] CRAN (R 4.1.0)
##  evaluate        0.14     2019-05-28 [1] CRAN (R 4.1.0)
##  fansi           0.4.2    2021-01-15 [1] CRAN (R 4.1.0)
##  farver          2.1.0    2021-02-28 [1] CRAN (R 4.1.0)
##  forcats       * 0.5.1    2021-01-27 [1] CRAN (R 4.1.0)
##  fs              1.5.0    2020-07-31 [1] CRAN (R 4.1.0)
##  gargle          1.1.0    2021-04-02 [1] CRAN (R 4.1.0)
##  generics        0.1.0    2020-10-31 [1] CRAN (R 4.1.0)
##  ggplot2       * 3.3.3    2020-12-30 [1] CRAN (R 4.1.0)
##  glue            1.4.2    2020-08-27 [1] CRAN (R 4.1.0)
##  googledrive     1.0.1    2020-05-05 [1] CRAN (R 4.1.0)
##  googlesheets4   0.3.0    2021-03-04 [1] CRAN (R 4.1.0)
##  gtable          0.3.0    2019-03-25 [1] CRAN (R 4.1.0)
##  haven           2.4.1    2021-04-23 [1] CRAN (R 4.1.0)
##  highr           0.9      2021-04-16 [1] CRAN (R 4.1.0)
##  hms             1.1.0    2021-05-17 [1] CRAN (R 4.1.0)
##  htmltools       0.5.1.1  2021-01-22 [1] CRAN (R 4.1.0)
##  httr            1.4.2    2020-07-20 [1] CRAN (R 4.1.0)
##  ids             1.0.1    2017-05-31 [1] CRAN (R 4.1.0)
##  isoband         0.2.4    2021-03-03 [1] CRAN (R 4.1.0)
##  jsonlite        1.7.2    2020-12-09 [1] CRAN (R 4.1.0)
##  knitr           1.33     2021-04-24 [1] CRAN (R 4.1.0)
##  labeling        0.4.2    2020-10-20 [1] CRAN (R 4.1.0)
##  lattice         0.20-44  2021-05-02 [4] CRAN (R 4.1.0)
##  lifecycle       1.0.0    2021-02-15 [1] CRAN (R 4.1.0)
##  lubridate     * 1.7.10   2021-02-26 [1] CRAN (R 4.1.0)
##  magrittr        2.0.1    2020-11-17 [1] CRAN (R 4.1.0)
##  markdown        1.1      2019-08-07 [1] CRAN (R 4.1.0)
##  MASS            7.3-54   2021-05-03 [4] CRAN (R 4.0.5)
##  Matrix          1.3-3    2021-05-04 [4] CRAN (R 4.0.5)
##  mgcv            1.8-35   2021-04-18 [4] CRAN (R 4.0.5)
##  mime            0.10     2021-02-13 [1] CRAN (R 4.1.0)
##  modelr          0.1.8    2020-05-19 [1] CRAN (R 4.1.0)
##  munsell         0.5.0    2018-06-12 [1] CRAN (R 4.1.0)
##  nlme            3.1-152  2021-02-04 [4] CRAN (R 4.0.3)
##  openssl         1.4.4    2021-04-30 [1] CRAN (R 4.1.0)
##  pillar          1.6.1    2021-05-16 [1] CRAN (R 4.1.0)
##  pkgconfig       2.0.3    2019-09-22 [1] CRAN (R 4.1.0)
##  prettyunits     1.1.1    2020-01-24 [1] CRAN (R 4.1.0)
##  processx        3.5.2    2021-04-30 [1] CRAN (R 4.1.0)
##  progress        1.2.2    2019-05-16 [1] CRAN (R 4.1.0)
##  ps              1.6.0    2021-02-28 [1] CRAN (R 4.1.0)
##  purrr         * 0.3.4    2020-04-17 [1] CRAN (R 4.1.0)
##  R6              2.5.0    2020-10-28 [1] CRAN (R 4.1.0)
##  rappdirs        0.3.3    2021-01-31 [1] CRAN (R 4.1.0)
##  RColorBrewer    1.1-2    2014-12-07 [1] CRAN (R 4.1.0)
##  Rcpp            1.0.6    2021-01-15 [1] CRAN (R 4.1.0)
##  readr         * 1.4.0    2020-10-05 [1] CRAN (R 4.1.0)
##  readxl          1.3.1    2019-03-13 [1] CRAN (R 4.1.0)
##  rematch         1.0.1    2016-04-21 [1] CRAN (R 4.1.0)
##  rematch2        2.1.2    2020-05-01 [1] CRAN (R 4.1.0)
##  reprex          2.0.0    2021-04-02 [1] CRAN (R 4.1.0)
##  rlang           0.4.11   2021-04-30 [1] CRAN (R 4.1.0)
##  rmarkdown       2.8      2021-05-07 [1] CRAN (R 4.1.0)
##  rstudioapi      0.13     2020-11-12 [1] CRAN (R 4.1.0)
##  rvest           1.0.0    2021-03-09 [1] CRAN (R 4.1.0)
##  scales          1.1.1    2020-05-11 [1] CRAN (R 4.1.0)
##  selectr         0.4-2    2019-11-20 [1] CRAN (R 4.1.0)
##  stringi         1.6.2    2021-05-17 [1] CRAN (R 4.1.0)
##  stringr       * 1.4.0    2019-02-10 [1] CRAN (R 4.1.0)
##  sys             3.4      2020-07-23 [1] CRAN (R 4.1.0)
##  tibble        * 3.1.2    2021-05-16 [1] CRAN (R 4.1.0)
##  tidyr         * 1.1.3    2021-03-03 [1] CRAN (R 4.1.0)
##  tidyselect      1.1.1    2021-04-30 [1] CRAN (R 4.1.0)
##  tidyverse     * 1.3.1    2021-04-15 [1] CRAN (R 4.1.0)
##  tinytex         0.31     2021-03-30 [1] CRAN (R 4.1.0)
##  utf8            1.2.1    2021-03-12 [1] CRAN (R 4.1.0)
##  uuid            0.1-4    2020-02-26 [1] CRAN (R 4.1.0)
##  vctrs           0.3.8    2021-04-29 [1] CRAN (R 4.1.0)
##  viridisLite     0.4.0    2021-04-13 [1] CRAN (R 4.1.0)
##  withr           2.4.2    2021-04-18 [1] CRAN (R 4.1.0)
##  xfun            0.23     2021-05-15 [1] CRAN (R 4.1.0)
##  xml2            1.3.2    2020-04-23 [1] CRAN (R 4.1.0)
##  yaml            2.2.1    2020-02-01 [1] CRAN (R 4.1.0)
## 
## [1] /home/drizzle/R/x86_64-pc-linux-gnu-library/4.1
## [2] /usr/local/lib/R/site-library
## [3] /usr/lib/R/site-library
## [4] /usr/lib/R/library
```
