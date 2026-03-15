-- Metadata
instrument {
    name = "SMA S&R Sniper",
    overlay = true
}

-- Variables
methodID = input (1, "Type", input.string_selection, { "SMA S&R Sniper" })

maFastPeriod = input(1,"Ma Fast period",input.integer,1,1000,1)
MaValue = input(5,"Ma Value", input.string_selection,inputs.titles)
maSlowPeriod = input(34,"Ma Slow period",input.integer,1,1000,1)
signalPeriod = input(5,"Signal period",input.integer,1,1000,1)

input_group {
    "BUY",
    colorBuy = input { default = "green", type = input.color }, 
    visibleBuy = input { default = true, type = input.plot_visibility }
}

input_group {
    "SELL",
    colorSell = input { default = "red", type = input.color },
    visibleSell = input { default = true, type = input.plot_visibility }
}

-- Main
local titleValue = inputs[MaValue]
smaFast = sma(titleValue, maFastPeriod)
smaSlow = sma(titleValue, maSlowPeriod)
buffer1 = smaFast - smaSlow 
buffer2 = wma(buffer1, signalPeriod)

buyCondition = conditional(buffer1 > buffer2 and buffer1[1] < buffer2[1] and not (buffer1 < buffer2 and buffer1[1] > buffer2[1]))
buyCondition = conditional(buffer1 > buffer2 and buffer1[1] < buffer2[1])

sellCondition = conditional(buffer1 < buffer2 and buffer1[1] > buffer2[1] and not (buffer1 > buffer2 and buffer1[1] < buffer2[1]))
sellCondition = conditional(buffer1 < buffer2 and buffer1[1] > buffer2[1] )

plot_shape(
    (buyCondition),
    "BUY",
    shape_style.triangleup,
    shape_size.huge,
    colorBuy,
    shape_location.belowbar,
    -1,
    "BUY",
    "white"
) 

plot_shape(
    (sellCondition),
    "SELL",
    shape_style.triangledown,
    shape_size.huge,
    colorSell,
    shape_location.abovebar,
    -1,
    "SELL",
    "white"
)

input_group {
    "Resistance",
    level_1_color = input { default = "red", type = input.color },
    level_1_width = input { default = 2, type = input.line_width }
}

input_group {
    "Support",
    level_2_color = input { default = "green", type = input.color },
    level_2_width = input { default = 2, type = input.line_width }
}

local function m15(candle)
    c1 = candle.high
    c2 = candle.low
end

local methods = { m15 }
local resolution = "15m"

sec = security (current_ticker_id, resolution)
if sec then
   local method = methods [methodID]
   method (sec)
   plot (c1, "C1",   level_1_color, level_1_width, 0, style.levels, na_mode.continue)
   plot (c2, "C2",   level_2_color, level_2_width, 0, style.levels, na_mode.continue)
end