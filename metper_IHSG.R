# Libraries
library(quantmod)
library(forecast)
library(tseries)
library(ggplot2)

# Download IHSG data: https://finance.yahoo.com/quote/%5EJKSE/history/?period1=1546300800&period2=1709164800
getSymbols("^JKSE", src = "yahoo", from = "2019-01-01", to = "2024-02-29")
data <- data.frame(Date = index(JKSE), coredata(JKSE))

# Clean data
data_clean <- na.omit(data)
data_clean$Date <- as.Date(data_clean$Date)

# Time series (252 trading days/year)
ts_data <- ts(data_clean$JKSE.Adjusted, start = c(2019, 1), frequency = 252)

# Plot time series
plot(ts_data, main = "IHSG Time Series", ylab = "Close Price", xlab = "Date")

# Box-Cox transformation
lambda <- BoxCox.lambda(ts_data)
boxcox_ts <- BoxCox(ts_data, lambda)

# Differencing
diff_boxcox_ts <- diff(boxcox_ts)
tsdisplay(diff_boxcox_ts, main = "Differenced Box-Cox Time Series")

# Stationarity test
adf_test <- adf.test(diff_boxcox_ts, alternative = "stationary")
print(adf_test)

# Fit ARIMA models
model1 <- Arima(boxcox_ts, order = c(0,1,0), include.constant = TRUE)
model2 <- Arima(boxcox_ts, order = c(0,1,1), include.constant = TRUE)
model3 <- Arima(boxcox_ts, order = c(1,1,1), include.constant = TRUE)

# Model comparison
models <- list(model1, model2, model3)
aic_values <- sapply(models, AIC)
best_model_index <- which.min(aic_values)
best_model <- models[[best_model_index]]
cat("Best model:", best_model_index, "AIC =", aic_values[best_model_index], "\n")

# Diagnostics
checkresiduals(best_model)
jarque_bera <- jarque.bera.test(best_model$residuals)
print(jarque_bera)

# Forecast
forecast_result <- forecast(best_model, h = 30)
autoplot(forecast_result) +
  ggtitle("IHSG Forecast (30 Trading Days)") +
  xlab("Date") +
  ylab("Close Price")

# Forecast results
print(head(forecast_result))
