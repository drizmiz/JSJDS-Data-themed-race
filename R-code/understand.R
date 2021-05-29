# Created by: drizzle
# Created on: 2021/5/29

# Models for Counterfactual Proxies via Synthetic Control and Panel Data

library(tidyverse)
library(ggdag)

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
  Y ~ U1,
  Z ~ U2,
  W ~ U3,
  labels = lbl
  )

ggplot(dag, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_point(colour = 'Gray') +
  geom_dag_edges(
    curvature = 0,
    arrow_bidirected = grid::arrow(
      length = grid::unit(x = 0, units = "pt")
    )
  ) +
  geom_dag_text(colour = 'white') +
  geom_dag_label_repel(aes(label = label))+
  theme_dag_blank()

