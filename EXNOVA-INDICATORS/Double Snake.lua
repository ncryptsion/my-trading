-- Metadata
instrument {
    name = "Double Snake",
    overlay = true
}

-- Variables
len = 13
smaHigh = sma(high, len)
smaLow = sma(low, len)

Hlv = iff(close > smaHigh , 1 ,iff( close < smaLow , -1 , Hlv[1]))
sslDown = iff(Hlv < 0 , smaHigh , smaLow)
sslUp   = iff(Hlv < 0 , smaLow , smaHigh)

-- Main
plot(sslDown, "down", "#FF0000" , width, -1, style.solid_line, na_mode.continue)
plot(sslUp, "up", "#00FF00" , width, -1, style.solid_line, na_mode.continue)