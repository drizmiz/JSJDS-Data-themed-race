import pandas as pd
import json
from pyecharts import options as opts
from pyecharts.charts import Timeline, Map
from pyecharts.globals import ThemeType
import numpy as np
tl = Timeline(init_opts=opts.InitOpts(
    theme=ThemeType.INFOGRAPHIC,
    bg_color='white',
    page_title='预期寿命'
))
with open("./country_ce.json", 'r', encoding='utf-8') as f:
    ce_dict = json.load(f)

df = pd.read_csv('./FDI_filled_m.csv')
df.iloc[:, 3] = df.iloc[:, 3].apply(np.log1p)
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
                max_=df[df.iloc[:, 0] == year].iloc[:, 3].max()),
            toolbox_opts=opts.ToolboxOpts(),

        )
    )
    tl.add(map, f"{year}年")
# tl.render("vis1.html")
tl.render("vis2.html")