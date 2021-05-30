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
with open("./data/syno_dict.json", 'r', encoding='utf-8') as f:
    syno_dict = json.load(f)

df = pd.read_csv('./data/LE.csv')
for year in [2000, 2010, 2015, 2019]:
    map = (
        Map()
        .add(df.columns.tolist()[-1],
             [[row[0], row[-1]]
                 for _, row in df[(df['Period'] == year) & (df['Dim1'] == "Both sexes")].iterrows()],
             maptype="world",
             is_map_symbol_show=False,  # 不描点
             )
        .set_series_opts(label_opts=opts.LabelOpts(is_show=False))
        .set_global_opts(
            title_opts=opts.TitleOpts(title=f"{year}年预期寿命"),
            visualmap_opts=opts.VisualMapOpts(min_=df['First Tooltip'].min(),max_=df['First Tooltip'].max()),
            toolbox_opts=opts.ToolboxOpts()
        )
    )
    tl.add(map, f"{year}")
tl.render("./out/life_expectancy.html")
