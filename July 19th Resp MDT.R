#Norman Pang 2021

getwd()

access_db <- read.csv("access_database.csv", na.strings="")
access_db
head(access_db)
summary(access_db)
str(access_db)

icnarc_db <- read.csv("icnarc_database.csv", na.strings="")
icnarc_db
head(icnarc_db)
summary(icnarc_db)
str(icnarc_db)

# Change the colname of the icnarc database 'Admission.number' to 'ICNARC_number' 
# so they match and can merge according to ICNARC admission
names(icnarc_db)[names(icnarc_db) == 'Admission.number'] <- 'ICNARC_number'
str(icnarc_db)

# Merge the audic MS Access database and existing ICNARC audit office database
total_db <- merge(access_db, icnarc_db, by="ICNARC_number")
str(total_db)
head(total_db)

# Create CSV for merged databases
write.csv(total_DB, "merged.csv", row.names=FALSE)

# Pick rows for the 19/07/2021 resp MDT
final_db <- data.frame(total_db$ICNARC_number,
                       total_db$MRN,
                       total_db$Age.x,
                       total_db$Sex.x,
                       total_db$Ethnicity.x,
                       total_db$date_symtoms,
                       total_db$date_positive_swab,
                       total_db$date_hospital_admission,
                       total_db$date_icu_admission,
                       total_db$readmission_ICU,
                       total_db$DNAR_CPR_on_ICU,
                       total_db$treatment_CPAP_limited,
                       total_db$team_making_tep,
                       total_db$patient_involved_escalation,
                       total_db$pre_ICU_days_FM,
                       total_db$pre_ICU_days_HFNO,
                       total_db$pre_ICU_days_CPAP,
                       total_db$ICU_days_HFNO,
                       total_db$ICU_days_CPAP,
                       total_db$intubated,
                       total_db$date_intubation,
                       total_db$fio2_pre_intubation,
                       total_db$input_days_mechanical_ventilation,
                       total_db$days_pf.8,
                       total_db$days_vt.8,
                       total_db$days_pPeak.35,
                       total_db$inhaled_nitric,
                       total_db$inhaled_prostaglandin,
                       total_db$tracheostomy,
                       total_db$date_tracheostomy,
                       total_db$Length.of.unit.stay,
                       total_db$Length.stay.days.decimal,
                       total_db$Length.of.hospital.stay,
                       total_db$Status.at.unit.discharge,
                       total_db$Status.hospital.discharge,
                       total_db$Status.Overall
                       )

colnames(final_db) <- c("ICNARC_number",
                        "MRN",
                        "Age.x",
                        "Sex.x",
                        "Ethnicity.x",
                        "date_symtoms",
                        "date_positive_swab",
                        "date_hospital_admission",
                        "date_icu_admission",
                        "readmission_ICU",
                        "DNAR_CPR_on_ICU",
                        "treatment_CPAP_limited",
                        "team_making_tep",
                        "patient_involved_escalation",
                        "pre_ICU_days_FM",
                        "pre_ICU_days_HFNO",
                        "pre_ICU_days_CPAP",
                        "ICU_days_HFNO",
                        "ICU_days_CPAP",
                        "intubated",
                        "date_intubation",
                        "fio2_pre_intubation",
                        "input_days_mechanical_ventilation",
                        "days_pf.8",
                        "days_vt.8",
                        "days_pPeak.35",
                        "inhaled_nitric",
                        "inhaled_prostaglandin",
                        "tracheostomy",
                        "date_tracheostomy",
                        "Length.of.unit.stay",
                        "Length.stay.days.decimal",
                        "Length.of.hospital.stay",
                        "Status.at.unit.discharge",
                        "Status.hospital.discharge",
                        "Status.Overall"
                        )

str(final_db)

# Remove rows for which data entry hasnt been started
final_db <- final_db[!is.na(final_db$date_positive_swab), ]
final_db

# Create csv for final deliverable
write.csv(final_db, "merged incomplete removed.csv", row.names=FALSE)