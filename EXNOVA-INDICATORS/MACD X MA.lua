-- Metadata
instrument {
    name = "MACD X MA",
    overlay = true
}

MaFast_period = input(12,"MA Fast Period",input.integer,1,1000,1)
MaFast_average = input(2,"MA Fast Type", input.string_selection,averages.titles)
MaFast_title = input(1,"Ma Fast Price", input.string_selection,inputs.titles)

MaSlow_period = input(26,"MA Slow Period",input.integer,1,1000,1)
MaSlow_average = input(2,"MA Slow Type", input.string_selection,averages.titles)
MaSlow_title = input(1,"MA Slow Price", input.string_selection,inputs.titles)

Signal_period = input(9,"Signal Period",input.integer,1,1000,1)

MaTrend_period = input(200,"MA Trend Period",input.integer,1,1000,5)
MaTrend_average = input(2,"MA Trend Type", input.string_selection,averages.titles)
MaTrend_title = input(1,"MA Trend Price", input.string_selection,inputs.titles)

-- Varaibles
input_group {
    "Area Up and Down",
    colorAreaUp = input { default = "rgba(34, 139, 34, 0.3)", type = input.color },  
    colorAreaDown = input { default = "rgba(220, 20, 60, 0.3)", type = input.color },
    visibleArea = input { default = true, type = input.plot_visibility } 
}

input_group {
    "MA Fast Line",
    colorFast = input { default = "#FF6C58", type = input.color },
    widthFast = input { default = 1, type = input.line_width},
    visibleFast = input { default = true, type = input.plot_visibility }
}

input_group {
    "MA Slow Line",
    colorSlow = input { default = "#DBCF0D", type = input.color },
    widthSlow = input { default = 2, type = input.line_width},
    visibleSlow = input { default = true, type = input.plot_visibility }
}

input_group {
    "MA Trend Line",
    colorTrend = input { default = "#56CEFF", type = input.color },
    widthTrend = input { default = 3, type = input.line_width},
    visibleTrend = input { default = true, type = input.plot_visibility }
}

input_group {
    "Buy MACD",
    colorBuy3 = input { default = "#FF6BF1", type = input.color }, 
    visibleBuy3 = input { default = true, type = input.plot_visibility }
}

input_group {
    "Sell MACD",
    colorSell3 = input { default = "#B42EFF", type = input.color },
    visibleSell3 = input { default = true, type = input.plot_visibility }
}

input_group {
    "Buy Zero",
    colorBuy4 = input { default = "#DBCF0D", type = input.color }, 
    visibleBuy4 = input { default = true, type = input.plot_visibility }
}

input_group {
    "Sell Zero",
    colorSell4 = input { default = "#DB4931", type = input.color },
    visibleSell4 = input { default = true, type = input.plot_visibility }
}

input_group {
    "Buy Histo",
    colorBuy5 = input { default = "#25E154", type = input.color }, 
    visibleBuy5 = input { default = true, type = input.plot_visibility }
}

input_group {
    "Sell Histo",
    colorSell5 = input { default = "#FF7700", type = input.color },
    visibleSell5 = input { default = true, type = input.plot_visibility }
}

local avgFast = averages[MaFast_average]
local titleFast = inputs[MaFast_title]

local avgSlow = averages[MaSlow_average]
local titleSlow = inputs[MaSlow_title]

local avgTrend = averages[MaTrend_average]
local titleTrend = inputs[MaTrend_title]

if visibleFast == true then
    plot(avgFast(titleFast,MaFast_period),"Ma Fast",colorFast,widthFast)
end

if visibleSlow == true then
    plot(avgSlow(titleSlow,MaSlow_period),"Ma Slow",colorSlow,widthSlow)
end

if visibleTrend == true then
    plot(avgTrend(titleTrend,MaTrend_period),"Ma Trend",colorTrend,widthTrend)
end

emaFast = ema(close,MaFast_period)
emaSlow = ema(close,MaSlow_period)
macd = emaFast - emaSlow

signal = ema(macd,Signal_period)

if (sec ~= nil) then
    MaFast0 = avgFast(titleFast,MaFast_period)
    MaFast1 = MaFast0[1]
    MaSlow0 = avgSlow(titleSlow,MaSlow_period)
    MaSlow1 = MaSlow0[1]
    MaTrend0 = avgTrend(titleTrend,MaTrend_period)
    MaTrend1 = MaTrend0[1]
    
 
    if(visibleBuy3 == true) then      
            plot_shape((macd > signal and macd[1] < signal[1] and close > MaFast0 and MaFast0 > MaTrend0),
                "Call3",
                shape_style.arrowup,
                shape_size.normal,
                colorBuy3,
                shape_location.belowbar,
                0,
                "BUY MACD",
                colorBuy3  
               ) 
    end

     if (visibleSell3 == true) then                         
          plot_shape((macd < signal and macd[1] > signal[1] and close < MaFast0 and MaFast0 < MaTrend0),
                "Put3",
                shape_style.arrowdown,
                shape_size.normal,
                colorSell3,
                shape_location.abovebar,
                0,
                "SELL MACD",
                colorSell3
            )
    end    

    if (visibleArea == true) then
        fill(MaFast0,MaSlow0,"Area", MaFast0 > MaSlow0 and colorAreaUp or MaFast0 < MaSlow0 and colorAreaDown )
   end
end

emaFast = avgFast(titleFast,MaFast_period)
emaSlow = avgSlow(titleSlow,MaSlow_period)
macd = emaFast - emaSlow

signal = avgSignal(macd,Signal_period)
histo = macd - signal

if (sec ~= nil) then
    
    MaFast0 = avgFast(titleFast,MaFast_period)
    MaFast1 = MaFast0[1]
    
    MaSlow0 = avgSlow(titleSlow,MaSlow_period)
    MaSlow1 = MaSlow0[1]
    
    MaTrend0 = avgTrend(titleTrend,MaTrend_period)
    MaTrend1 = MaTrend0[1]
    
     if(visibleBuy4 == true) then                        
            plot_shape((macd[1] < 0 and macd > 0 ),
                "Call4",
                shape_style.arrowup,
                shape_size.normal,
                colorBuy4,
                shape_location.belowbar,
                0,
                "BUY Zero",
                colorBuy4  
               ) 
    end

    if (visibleSell4 == true) then                              
          plot_shape((macd[1] > 0 and macd < 0 ),
                "Put4",
                shape_style.arrowdown,
                shape_size.normal,
                colorSell4,
                shape_location.abovebar,
                0,
                "SELL Zero",
                colorSell4
            )
    end    

    if(visibleBuy5 == true) then                               
            plot_shape((histo[1] < 0 and histo > 0 ),
                "Call5",
                shape_style.arrowup,
                shape_size.normal,
                colorBuy5,
                shape_location.belowbar,
                0,
                "BUY H",
                colorBuy5  
               ) 
    end

     if (visibleSell5 == true) then                               
          plot_shape((histo[1] > 0 and histo < 0 ),
                "Put5",
                shape_style.arrowdown,
                shape_size.normal,
                colorSell5,
                shape_location.abovebar,
                0,
                "SELL H",
                colorSell5
            )
    end    

    if (visibleArea == true) then
        fill(MaFast0,MaSlow0,"Area", MaFast0 > MaSlow0 and colorAreaUp or MaFast0 < MaSlow0 and colorAreaDown )
   end
end

