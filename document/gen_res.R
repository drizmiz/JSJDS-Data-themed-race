
## ----echo = FALSE--------------------------------------------------------------------------------------------------------------------
library(ggdag)
library(tidyverse)
library(VIM)
library(showtext)

## ----fig.cap = "数据模型示意图", out.width = '65%', out.height = '60%', fig.align = 'center'----

lbl = c(
  "X" = "一带一路参与程度",
  "Y" = "FDI (外国直接投资)",
  "Z" = "经济发展水平",
  "W" = "健康水平 (若干指标)",
  "U1",
  "U2",
  "U3"
)
dag <- dagify(
  W ~ Z,
  Z ~ Y,
  Y ~ X,
  W ~ X,
  Y ~ U1,
  Z ~ U2,
  W ~ U3,
  labels = lbl
  )

showtext_auto()

pdf("./t/DAG.pdf", width = 9, height = 4)
gp1 <- ggplot(dag, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_point(colour = 'Gray') +
  geom_dag_edges(
    curvature = 0,
    arrow_bidirected = grid::arrow(
      length = grid::unit(x = 0, units = "pt")
    )
  ) +
  geom_dag_text(colour = 'white') +
  geom_dag_label_repel(aes(label = label)) +
  theme_dag_blank()
print(gp1)
graphics.off()



## ----fig.cap = "缺失数据示意图", out.width = '65%', out.height = '60%', fig.align = 'center'----

fdi <- read_csv(
  file = "../data/investment/FDI_useful.csv",
  col_types = cols(
    年份 = col_integer(),
    国家 = col_factor()
  )
) %>% select(-地区)
country_name <- fdi[["国家"]] %>% unique()
list_c <- country_name %>%
  map(~ fdi %>% filter(国家 == .x) %>% .[["年份"]])
fdi_na <- fdi %>% complete(年份, 国家)

pdf("./t/Missing data.pdf", width = 9, height = 4)
matrixplot(fdi_na)
graphics.off()
