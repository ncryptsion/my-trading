instrument {
    name = 'SNIPER',
    short_name = 'super',
    overlay = true
}

MaFast_period = input(1, "Ma Fast period", input.integer, 1, 1000, 1)
MaValue = input(5, "Ma Value", input.string_selection, inputs.titles)

MaSlow_period = input(34, "Ma Slow period", input.integer, 1, 1000, 1)
Signal_period = input(5, "Signal period", input.integer, 1, 1000, 1)

input_group {
    "Compra",
    colorBuy = input { default = "green", type = input.color },
    visibleBuy = input { default = true, type = input.plot_visibility }
}

input_group {
    "Venda",
    colorSell = input { default = "red", type = input.color },
    visibleSell = input { default = true, type = input.plot_visibility }
}

local titleValue = inputs[MaValue]

-- média móvel linear rápida
smaFast = sma(titleValue, MaFast_period)

-- média móvel linear devagar
smaSlow = sma(titleValue, MaSlow_period)

-- cálculo diferencial - série
buffer1 = smaFast - smaSlow

-- cálculo da média móvel ponderada - série
buffer2 = wma(buffer1, Signal_period)

buyCondition = conditional(buffer1 > buffer2 and buffer1[1] < buffer2[1] and not (buffer1 < buffer2 and buffer1[1] > buffer2[1]))
buyCondition = conditional(buffer1 > buffer2 and buffer1[1] < buffer2[1])

sellCondition = conditional(buffer1 < buffer2 and buffer1[1] > buffer2[1] and not (buffer1 > buffer2 and buffer1[1] < buffer2[1]))
sellCondition = conditional(buffer1 < buffer2 and buffer1[1] > buffer2[1])

plot_shape(
    (buyCondition),
    "SNIPER",
    shape_style.triangleup,
    shape_size.huge,
    colorBuy,
    shape_location.belowbar,
    -1,
    "SNIPER  ",
    "green"
)

plot_shape(
    (sellCondition),
    "SNIPER ",
    shape_style.triangledown,
    shape_size.huge,
    colorSell,
    shape_location.abovebar,
    -1,
    "SNIPER  ",
    "red"
)
