-- Metadata
instrument {
    name = "Ahead MACD",
    overlay = false
}

-- Variables
lc = 17.5185
sc = 8.3896
sp = 9.0503
src = close
fs = nz(fs[1]) + 2.0 / (1.0 + sc) * (src- nz(fs[1]))
ss = nz(ss[1]) + 2.0 / (1.0 + lc) * (src - nz(ss[1]))
r = fs - ss
s = nz(s[1]) + 2.0/(1 + sp)*(r - nz(s[1]))

-- Main
plot(s, "Dinapoli MACD", "teal", 2)
rect {
    first = 0,
    second = r,
    color = iff(r>0, "green", "red"),
    width = 0.4
}