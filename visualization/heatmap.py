import pandas as pd
import json
from pyecharts import options as opts
from pyecharts.charts import Timeline, Map
import numpy as np
tl = Timeline()
with open("./country_ce.json", 'r', encoding='utf-8') as f:
    ce_dict = json.load(f)

df = pd.read_csv('./FDI_useful.csv')
df.iloc[:,3] = df.iloc[:,3].apply(np.log1p)
for year in range(2003, 2019+1):
    map = (
        Map()
        .add(df.columns.tolist()[-1],
             [[ce_dict[row['国家']], row[3]]
                 for _, row in df[df.iloc[:, 0] == year].iterrows()],
             maptype="world",
             is_map_symbol_show=False,  # 不描点
             )
        .set_series_opts(label_opts=opts.LabelOpts(is_show=False))
        .set_global_opts(
            title_opts=opts.TitleOpts(title=f"{year}年外商直接投资情况"),
            visualmap_opts=opts.VisualMapOpts(
                max_=df[df.iloc[:, 0] == year].iloc[:,3].max(), is_piecewise=True),
        )
    )
    tl.add(map, f"{year}年")
tl.render("vis1.html")
