# dependency on fr_DGASUSGULF and fr_DCOILWTICO

# last 6 month data for DJIA, SP500, and NASDAQCOM
fr_gaspercentoil <- fr_DGASUSGULF
fr_gaspercentoil$DGASUSGULF <- (fr_DGASUSGULF$DGASUSGULF/fr_DCOILWTICO$DCOILWTICO)*100
names(fr_gaspercentoil)[2] <- "Percent"

# Plot it
p4 <- ggplot(fr_gaspercentoil, aes(x=date, y=Percent))
p4 <- p4 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limits = c(2.6,3.2)) +
  stat_smooth(method = lm) +
  labs(title="4. Gasoline % of Oil Price", x="", y="% of Oil Price") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))
  

