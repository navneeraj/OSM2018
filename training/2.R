
  rail_states<- read.csv("C:/Users/ministry of finance/Documents/Economic_Survey2016-17/Rail_final/UTS/use_cris_state_names2.csv")
  rail_states$Station_code<- as.character(rail_states$Station_code)
  rail_states$STATION_NAME<- as.character(rail_states$STATION_NAME)
  uts<- filter(uts_data,(YEAR == 2015 & MON>=4)|(YEAR == 2016 & MON<=3))
  # merging state codes to the railway data- first for the orgin stations and later for destination stations
  names(rail_states)[names(rail_states) == 'Station_code'] <- 'ORGIN_CODE'
  uts_org<- merge(x = uts, y = rail_states[ ,c("ORGIN_CODE","State_code","LATITUDE","LONGITUDE","DIVISION_CODE")], by = "ORGIN_CODE", all.x = T)
  names(uts_org)[names(uts_org) == 'State_code'] <- 'ORGIN_ST'
  
  # merging state names for destination states
  names(rail_states)[names(rail_states) == 'ORGIN_CODE'] <- 'DESTN_CODE'
  uts_org$DESTN_CODE<- as.character(uts_org$DESTN_CODE)
  uts_final<- merge(x = uts_org, y = rail_states[ ,c("DESTN_CODE","State_code","LATITUDE","LONGITUDE","DIVISION_CODE")], by = "DESTN_CODE", all.x = T)
  names(uts_final)[names(uts_final) == 'State_code'] <- 'DESTN_ST'
  
  names(uts_final)[names(uts_final) == 'LATITUDE.x'] <- 'Orgin_lat'
  names(uts_final)[names(uts_final) == 'LONGITUDE.x'] <- 'Orgin_long'
  names(uts_final)[names(uts_final) == 'DIVISION_CODE.x'] <- 'Orgin_div'
  names(uts_final)[names(uts_final) == 'LATITUDE.y'] <- 'Destn_lat'
  names(uts_final)[names(uts_final) == 'LONGITUDE.y'] <- 'Destn_long'
  names(uts_final)[names(uts_final) == 'DIVISION_CODE.y'] <- 'Destn_div'
  
  
  uts_final$ORGIN_CODE<- as.character(uts_final$ORGIN_CODE)
  uts_final$ORGIN_ST<- as.character(uts_final$ORGIN_ST)
  uts_final$DESTN_CODE<- as.character(uts_final$DESTN_CODE)
  uts_final$DESTN_ST<- as.character(uts_final$DESTN_ST)
  
  uts_final<-filter(uts_final, (!(ORGIN_ST %in% c("","MZ","AR","MN", "#N/A"))) & (!(DESTN_ST %in% c("","MZ","AR","MN","#N/A"))))
  
  
  
  # keeping non zero passenger pairs
  uts_final<- uts_final[uts_final$PASSENGER>0,]
  # checking whether all the origin and destination pairs have a relevant state
  # x<- uts_final[(is.na(uts_final$DESTN_ST)>0) |(is.na(uts_final$ORGIN_ST)>0) ,]
  # changing Telangana state to Andhra Pradesh
  uts_final$ORGIN_ST[uts_final$ORGIN_ST== "TL"]<- "AP"
  uts_final$DESTN_ST[uts_final$DESTN_ST== "TL"]<- "AP"
  # KB- "Khairabad is in UP. My station list puts it in Delhi as Karol bagh. Correcting it here
  uts_final$ORGIN_ST[uts_final$ORGIN_CODE== "KB"]<- "UP"
  uts_final$DESTN_ST[uts_final$DESTN_CODE== "KB"]<- "UP"
  # creating flag for interstate and intrastate travel. 1 is intra state and 0 is inter state
  uts_final$ssflag[uts_final$ORGIN_ST ==uts_final$DESTN_ST] <- 1
  uts_final$ssflag[uts_final$ORGIN_ST !=uts_final$DESTN_ST] <- 0
  # there are repeated rows in the data. Keeping unique values here
  # uts_final$Orgin_div<-  NULL
  # uts_final$Destn_div<-  NULL
  uts_final<- unique(uts_final)
  uts_final<- filter(uts_final, !((is.na(ORGIN_ST) | is.na(DESTN_ST))))
  #calculate the distance between all the stations
  uts_final$distance<- round((distHaversine(uts_final[,c(10,9)],uts_final[,c(14,13)] ))/1000)
  
  uts_final$Orgin_div<-  NULL
   uts_final$Destn_div<-  NULL
  uts_final<- unique(uts_final)
   
uts_finalc<- data.table(uts_final)
uts_final<- data.table(uts_final)
#names(uts_finalc)[names(uts_finalc) == 'ORGIN_CODE'] <- 'DESTN_CODE1'
#names(uts_finalc)[names(uts_finalc) == 'DESTN_CODE'] <- 'ORGIN_CODE'
#names(uts_finalc)[names(uts_finalc) == 'DESTN_CODE1'] <- 'DESTN_CODE'

uts_finalc$key <- paste0(uts_finalc$DESTN_CODE,"-",uts_finalc$DESTN_NAME,"-",uts_finalc$MON,"-",uts_finalc$ORGIN_CODE,"-",uts_finalc$ORGIN_NAME)
setkey(uts_finalc, key)
uts_final$key <- paste0(uts_finalc$ORGIN_CODE,"-",uts_finalc$ORGIN_NAME,"-",uts_final$MON,"-",uts_final$DESTN_CODE,uts_finalc$DESTN_CODE,"-",uts_finalc$DESTN_NAME)
setkey(uts_final, key)
uts_finalcc<- select(uts_finalc,key, PASSENGER )

m_201516 <- merge(x = uts_final, y = uts_finalcc, all = TRUE)

names(m_201516)[names(m_201516) == 'PASSENGER.x'] <- 'Export'
names(m_201516)[names(m_201516) == 'PASSENGER.y'] <- 'Import'
m_201516$Import[is.na(m_201516$Import)]<- 0
m_201516$Export[is.na(m_201516$Export)]<- 0

saveRDS(m_201516, "m_201516.rds")




xxx<- read.csv("loop.csv")
for (i in 2:11)
{
  railextract(fyear = xxx[i,"fyear"], fmonth = xxx[i,"fmonth"],tyear = xxx[i,"tyear"],tmonth = xxx[i,"tmonth"], dist= xxx[i,"dist"])
  gc()
} 
