# library(RFM)
# library(lubridate)
# library(data.table)
# transactions <- fread("transactions.csv")
# transactions[, TransDate:=dmy(TransDate, tz="UTC")]
# RFM <- calculateRFM(transactions, 60, 20, 20)
#
# RFM
#
# install.packages("roxygen2")
# library(roxygen2)
