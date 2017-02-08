#' calcualteRFM
#'
#' Calcualte the weight of an RFM score: recency, frequency, monetary
#'
# Arguments
#' @param data - data
#' @param r - recency
#'
#' @details
#' \code{data} blablabla
#'
#' @return Returns a RFM model
calculateRFM <- function(data, weight_recency=1, weight_frequency=1, weight_monetary=1){

  # Ensure that the weights add up to one
  weight_recency2 <- weight_recency/sum(weight_recency, weight_frequency, weight_monetary)
  weight_frequency2 <- weight_frequency/sum(weight_recency, weight_frequency, weight_monetary)
  weight_monetary2 <- weight_monetary/sum(weight_recency, weight_frequency, weight_monetary)

  # RFM measures
  max.Date <- max(transactions$TransDate)
  temp <- data[,list(
    recency = as.numeric(max.Date - max(TransDate)),
    frequency = .N,
    monetary = sum(PurchAmount)/.N),
    by="Customer"
    ]

  # RFM scores
  temp <- temp[,list(Customer,
    recency = as.numeric(cut2(-recency, g=3)),
    frequency = as.numeric(cut2(frequency, g=3)),
    monetary = as.numeric(cut2(monetary, g=3)))]

  # Overall RFM score
  temp[,finalscore:=weight_recency2*recency+weight_frequency2*frequency+weight_monetary2*monetary]

  # RFM group
  temp[,group:=round(finalscore)]

  # Return final table
  return(temp)
}

