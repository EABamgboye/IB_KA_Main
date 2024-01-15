
## read ibadan ward shape files
df_ib = st_read(file.path(NuDPDir, "ibadan_metro_ward_fiveLGAs", "Ibadan_metro_fiveLGAs.shp")) %>%
  mutate(WardName = ifelse(WardName == 'Oranyan' & LGACode == '31007', 'Oranyan_7', WardName))

df_ib$ward_color <- ifelse(df_ib$WardName %in% c("Agugu", "Olopomewa", "Challenge", "Bashorun"), 
                           "Sampled", "Unsampled")
ib_w <- df_ib$WardName

write.csv(ib_w, file.path("NuDPDir", "ib_wards.csv"), row.names = FALSE)

p <- ggplot(df_ib) +
  geom_sf(aes(fill = ward_color)) +
  scale_fill_manual(
    values = c("Sampled" = "plum", "Unsampled" = "white"), 
    na.value = "transparent"  # Set NA values to transparent
  )+
  #geom_sf_text(data = df, aes(label = WardName), colour = "black")+
  #geom_point(data = dplyr::filter(cdc, State=="Oyo"), mapping = aes(x = Longitude, y = Latitude), colour = "red", size = 2.5) +
  geom_text_repel(
    data = df_ib,
    aes(label =  WardName, geometry = geometry),color ='black',
    stat = "sf_coordinates", min.segment.length = 0, size = 3.5, force = 1)+
  map_theme()+ 
  labs(title= "Ibadan Metro area showing Wards sampled ")+
  coord_sf()

ggsave(paste0(ResultDir,"/", Sys.Date(), "/", 'locations_cdc_ibadan3.png'), p, width = 8, height = 6)

##Kano
df_ko = st_read(file.path(NuDPDir, "Kano_metro_ward_fiveLGAs", "Kano_metro_ward_fiveLGAs.shp"))

df_ko$ward_color <- ifelse(df_ko$WardName %in% c("Zango", "Tudun Wazurchi", "Fagge D2", "Dorayi", "Gobirawa"), 
                           "Sampled", "Unsampled")

p <- ggplot(df_ko) +
  geom_sf(aes(fill = ward_color)) +
  scale_fill_manual(
    values = c("Sampled" = "light blue", "Unsampled" = "white"), 
    na.value = "transparent"  # Set NA values to transparent
  )+
  #geom_sf_text(data = df, aes(label = WardName), colour = "black")+
  #geom_point(data = dplyr::filter(cdc, State=="Oyo"), mapping = aes(x = Longitude, y = Latitude), colour = "red", size = 2.5) +
  geom_text_repel(
    data = df_ko,
    aes(label =  WardName, geometry = geometry),color ='black',
    stat = "sf_coordinates", min.segment.length = 0, size = 3.5, force = 1)+
  map_theme()+ 
  labs(title= "Kano Metro Area showing wards selected for study")+
  coord_sf()

ggsave(paste0(ResultDir,"/", Sys.Date(), "/", 'Ibadan Metro showing Ento Wards.pdf'), p, width = 8, height = 6)
