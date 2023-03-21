install.packages("choroplethr")
install.packages("choroplethrMaps")
library(choroplethrMaps)
library(choroplethr)


newdata<-read.csv("F:/SUMMER STATS SEMINARS 2018/Geospatial - Data journalism/GEO CLASS/BEA.csv")

state_choropleth(newdata, title = "GDP by STATE",
                 legend = "US $")

#or 

newdata%>%state_choropleth( title = "GDP by STATE",
                            legend = "US $")

newdata<-read.csv("F:/SUMMER STATS SEMINARS 2018/Geospatial - Data journalism/GEO CLASS/CTY_MAP_WAGE.csv")
newdata

county_choropleth(newdata,title="Wages in 2016", legend="Sales $", num_colors=7)



#STATE MAP with county lines

library(choroplethr)

newdata<-read.csv("F:/Geospatial/CTY_MAP_WAGE.csv")

county_choropleth(newdata, state_zoom="illinois")

county_choropleth(newdata,
                  title      = "Statistical Seminars Rock",
                  legend     = "Sales",
                  state_zoom = "maryland")



BONUS MATERIAL  ;)


library(choroplethrMaps)
data(county.regions)
data(df_pop_county)
library(dplyr)
nyc_county_names = c("kings", "bronx", "new york", "queens", "richmond")
nyc_county_fips = county.regions %>% 
  filter(state.name == "new york" & county.name %in% nyc_county_names) %>%
  select(region)

county_choropleth(df_pop_county,
                  title = "Population of Counties in New York City",
                  legend = "Population",
                  num_colors = 1,
                  county_zoom = nyc_county_fips$region
                  )



install.packages("leaflet")
library(leaflet)
m <- leaflet() %>% setView(lng = -71.0589, lat = 42.3601, zoom = 12)
m %>% addTiles()

data(quakes)

# Show first 20 rows from the `quakes` dataset
leaflet(data = quakes[1:20,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag), label = ~as.character(mag))


#working with geojson files
#data source: http://eric.clst.org/tech/usgeojson/


#working with GeoJSON files
install.packages("geojsonio")
library(geojsonio)
getwd()
setwd("F:/SUMMER STATS SEMINARS 2018/Leaflet")
usstates <- geojsonio::geojson_read("gz_2010_us_040_00_500k.json",
                                    what = "sp")
# Or use the rgdal equivalent:
# nycounties <- rgdal::readOGR("json/nycounties.geojson", "OGRGeoJSON")

pal <- colorNumeric("viridis", NULL)
head(usstates)
leaflet(usstates) %>%
  addTiles() %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
              fillColor = ~pal(log10(CENSUSAREA)),
              label = ~paste0(NAME, ": ", formatC(CENSUSAREA, big.mark = ","))) %>%
  addLegend(pal = pal, values = ~log10(CENSUSAREA), opacity = 1.0,
            labFormat = labelFormat(transform = function(x) round(10^x)))