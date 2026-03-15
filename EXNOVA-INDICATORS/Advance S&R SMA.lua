instrument { name = "Advance S&R SMA", icon="jpg", overlay = true }

input_group {
    "BUY", 
    comprar_color = input {default = "green", type = input.color} 
}

input_group {
    "Max/Min Period", 
    doch_time = input {default = "11", type = input.string} 
}

input_group {
    "Micro Trend Period", 
    emaa_per = input {default = "11", type = input.string} 
}

input_group {
    "Macro Trend Period", 
    emab_per = input {default = "100", type = input.string} 
}

input_group {
    "Fast Average", 
    emac_per = input {default = "3", type = input.string} 
}

input_group {
    "Slow Average", 
    emad_per = input {default = "13", type = input.string} 
}

input_group {
    "Sell", 
    vender_color = input {default = "#fcf805", type = input.color} 
}

input_group {
    "Candles",
    positivo = input { default = "#0bd104",type = input.color },
    neutro   = input { default = "#2f3633", type = input.color },
    negativo = input { default = "#f70202",  type = input.color },
}

EMAA   = ema(close,emaa_per)
EMAB   = ema(close,emab_per)
EMAC   = ema(hlc3,emac_per)
EMAD   = ema(hlc3,emad_per)
upper  = highest (high, doch_time)
lower  = lowest  (low,  doch_time)



TA    = ((close > close[1]) and (close > EMAA) and (EMAA > EMAA[1]))
TB    = ((close < close[1]) and (close < EMAA) and (EMAA < EMAA[1]))
ENC   = ((EMAC[1] < EMAD[1]) and (EMAC > EMAD))
ENV   = ((EMAC[1] > EMAD[1]) and (EMAC < EMAD))

sec = security (current_ticker_id, "1m")
if sec then

local bar_color

if (TA == true) then
    bar_color = positivo
elseif (TB == true) then
    bar_color = negativo
else
    bar_color = neutro
end

    plot_candle (open, high, low, close, "ES", bar_color)
    plot (upper, "Resistencia", upline_color)
    plot (lower, "Suporte",lowline_color)
end

input_group { "CALL", call_color = input { default="#fcfc03", type = input.color } }
input_group { "PUT", put_color = input { default="#fcfc03", type = input.color } }

 
if ((close[1] < open[1]) and (close > open) and (close > high[1]) and close[2] >= open) then

    plot_shape(1,
            'Bull_Engulfing',
            shape_style.circle,
            shape_size.huge,
            call_color,
            shape_location.belowbar,
            0,
            "Alert",
            "A"
                      )
else
    if ((close[1] > open[1]) and (close < open) and (close < low[1]) and close[2] <= open) then

    plot_shape(1,
            'Bear_Engulfing',
            shape_style.circle,
            shape_size.huge,
            put_color,
            shape_location.abovebar,
            0,
            "Alert",
            "A"
                      )
    end
end 

input_group { "BUY", call_color = input { default="#0bd104", type = input.color } }
input_group { "SELL", put_color = input { default="#f70202", type = input.color } }

 
if ((close > close[1]) and (close[1] > open[2]) and (close[3] > close[2])) then

    plot_shape(1,
            'Bull_UP',
            shape_style.arrowup,
            shape_size.huge,
            call_color,
            shape_location.belowbar,
            0,
            "BUY",
            "#fcfc03"           
                       ) 
else
    if ((close < close[1]) and (close[1] < open[2]) and (close[3] < close[2])) then

    plot_shape(1,
            'Bear_DOWN',
            shape_style.arrowdown,
            shape_size.huge,
            put_color,
            shape_location.abovebar,
            0,
            "SELL",
            "#fcfc03"
                       )
    end
end


method_id = input (2, "Type", input.string_selection, { "M5" })

input_group {
    "Resistance",
    level_1_color = input { default = "#b59704", type = input.color },
    level_1_width = input { default = 2, type = input.line_width }
}


input_group {
    "Support",
    level_2_color = input { default = "#b59704", type = input.color },
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
   local method = methods [method_id]
   method (sec)

   plot (c1, "C1",   level_1_color, level_1_width, 0, style.levels, na_mode.continue)
   plot (c2, "C2",   level_2_color, level_2_width, 0, style.levels, na_mode.continue) 

end
percentage = input (3, "Percentage", input.double, 0.01, 100, 1.0) / 100
period = 3
input_group {
    "front.ind.dpo.generalline",
    up_color = input { default = "#02f7aa", type = input.color },
    down_color = input { default = "#f77902", type = input.color },
    width = input { default = 1, type = input.line_width }
}
local reference = make_series ()
reference:set(nz(reference[1], high))
local is_direction_up = make_series ()	
is_direction_up:set(nz(is_direction_up[1], true))
local htrack = make_series ()
local ltrack = make_series ()
local pivot = make_series ()
reverse_range = reference * percentage / 100
if get_value (is_direction_up) then
    htrack:set (max(high, nz(htrack[1], high)))
    if close < htrack[1] - reverse_range then
        pivot:set (htrack)
        is_direction_up:set (false)
        reference:set(htrack)
    end
else
    ltrack:set (min(low, nz(ltrack[1], low)))
    if close > ltrack[1] + reverse_range then
        pivot:set (ltrack)
        is_direction_up:set(true)
        reference:set (ltrack)
    end
end
color = is_direction_up() and  up_color or down_color
plot(pivot, 'ZZ', color, width, -1, style.solid_line, na_mode.continue)