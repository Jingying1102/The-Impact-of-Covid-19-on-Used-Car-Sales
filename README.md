# The-Impact-of-Covid-19-on-Used-Car-Sales
This project is a final project of course statistical consulting @UVA. This project analysed the used car sales since January 1992 to September 2020. The used car sales before and after the Great Recession fitted the same model. So the Great Recession doesn’t change the pattern of the used car sales. It just move the sales number to a lower level. With the assumption that the sales data after Covid-19 Recession would also fit our model before Covid-19, we added the mean residuals of the last four months to the model prediction of the future 12 months. In this way we get our final prediction between Oct.2020 and Sep.2021.
# modeling
The used car sales before the Great Recession fits our model SARIMA(1, 1, 1)×(0, 1, 1)12,the Covid-19 Recession would have similar impact on the used car sales,
it would change the sales number to a different level but not change the pattern, which means that the sales data after Covid-19 Recession would fit our model before Covid-19, SARIMA(1, 1, 1) × (0, 1, 1)12.
# data
The dataset contains 2 variables: Date, Sales. The 345 observations ranges from Jan. 1992 to Sep. 2020.
