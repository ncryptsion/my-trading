-- Variables
instrument {
    name = "SMA Sniper",
    short_name = "SMA Sniper",
    overlay = true
}

maFastPeriod = input(2, "Ma Fast period", input.integer, 1, 1000, 1)
MaValue = input(5, "Ma Value", input.string_selection, inputs.titles)

maSlowPeriod = input(34, "Ma Slow period", input.integer, 1, 1000, 1)
signalPeriod = input(5, "Signal period", input.integer, 1, 1000, 1)

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
smaSlow = sma(titleValue, MaSlow_period)
buffer1 = smaFast - smaSlow
buffer2 = wma(buffer1, signalPeriod)

buyCondition = conditional(buffer1 > buffer2 and buffer1[1] < buffer2[1] and not (buffer1 < buffer2 and buffer1[1] > buffer2[1]))
buyCondition = conditional(buffer1 > buffer2 and buffer1[1] < buffer2[1])

sellCondition = conditional(buffer1 < buffer2 and buffer1[1] > buffer2[1] and not (buffer1 > buffer2 and buffer1[1] < buffer2[1]))
sellCondition = conditional(buffer1 < buffer2 and buffer1[1] > buffer2[1])

plot_shape(
    (buyCondition),
    "BUY",
    shape_style.triangleup,
    shape_size.huge,
    colorBuy,
    shape_location.belowbar,
    -1,
    "BUY  ",
    "green"
)

plot_shape(
    (sellCondition),
    "SELL ",
    shape_style.triangledown,
    shape_size.huge,
    colorSell,
    shape_location.abovebar,
    -1,
    "SELL  ",
    "red"
)
