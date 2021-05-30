# visualization workspace
data:
- `world_country.json`: raw English-Chinese dict downloaded from website
- `country_ce.json`: a look-up dict modified based on our datasets. some more keys addeed or revised 
- `FDI_useful.csv`: dataset modified to delet HK, Macau and Taiwan. Since we believe they are inalienable parts of China, corresponding with API of echarts.
- `FDI_useful_filled.csv`: fill the default data of countries.
- `LE.csv`: datasets about life expectancy.
- `UFMR_m.csv`: under 5 mortality rate. remove the range of the numbers.
- `syno_dict.json`: prepared to replace some inconsistent country names.

scripts:
- `heatmap.py`: used to generate the heatmap with timeline.
- `mytool.ipynb`: some tests, and do some chores here.
- `world_health.ipynb`: visualize with world health data.
