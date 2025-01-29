# 4-Forecasting-Method

## Description
This project focuses on time series analysis and forecasting of IHSG (Jakarta Composite Index) closing prices using historical data. The analysis includes:
- **Data Preprocessing**: Handling missing values and applying Box-Cox transformation.
- **Modeling**: Fitting ARIMA models with varying parameters and selecting the best model using AIC.
- **Diagnostics**: Testing stationarity with Augmented Dickey-Fuller (ADF), analyzing residuals, and ensuring normality (Jarque-Bera test).
- **Forecasting**: Producing 30-day IHSG closing price forecasts with confidence intervals.

## Output
- Best model: **ARIMA(0,1,0) with drift**, selected based on AIC.
- The model passed diagnostics, confirming stationarity and normality of residuals.
- The forecast provides actionable insights into IHSG price trends over the next 30 trading days.

## Data Source
- IHSG data (2019-2024) from [Yahoo Finance](https://finance.yahoo.com/quote/%5EJKSE/history/).

## Tools
- R
