# My Trading
**NCryptsion's Trading Journey and Knowledge Hub.**<br>
This is based on my personal journey and experiences. You may use it as a source of learning, but it may not necessarily apply the same way for everyone, as each person is unique. Their mentality, behavior and likewise.

## Sayings
- The simpler the setup is, the better it is.

## Mistakes
- Never trade in a bad consolidation.
- Never trade in low volatility.
- Always learn from your mistakes.
- Always trust your setup, analysis and from what you have experienced. If you don’t trust your setup then don’t bother risking your money. If you trust your setup you see the long term not short term–as price can have fake momentums or hit stop loses of small traders.
	- **Example:** The volume bar EMA does not match with the amount of volume bar and their color. Such as the EMA is too high but the volume bars in many timeframe is full of red bars.

## Assets
### Gold (XAUUSD)
**Best Sessions**
- New York
- London–NY overlap

**Characteristics**
- Huge volatility.
- Big impulsive moves.
- Reacts strongly to news and liquidity.

### Silver (XAGUSD)
**Best Sessions**
- New York
- London–NY overlap

**Characteristics**
- More explosive breakouts than gold.
- Whipsaws during low liquidity (especially Asia session).
- Moves strongly with gold trends but often lags first, then accelerates.

## Indicators
**Main (Lower TF)**
- [Core Indicator](./Core%20Indicator.pine): Minimalistic and Simple-As-Possible Indicator I made.
  - 3 EMAs (14, 26, 50).
  - Automatically place a resistance and support from current day higher high and lower low.
  - Automatically place a resistance and support from the previous day higher high and lower low (dotted).
  - Detect current day and previous day trend.
  - Detect abnormally in Volume vs Trend.
  - Detect last 4 hours and 30 minutes trend.
  - Detect the volume of last 4 hours and 30 minutes.
  - Automatically place a resistance and support for the candle with the overall ATH in both it's upper (resistance and support) and lower wicked (resistance) as purple dotted horizontal line.
- [Core Divergence](./Core%20Divergence.pine): Improved version of the existing one created by [fikira12](https://github.com/fikira12).
  - Detect reversals, overbought and oversold.
  - Better resistance and support placed from repetitive momentums.

**Main (Higher TF)**
- **%R Trend Exhaustion**
  - Used to find potential reversals.
  - Awful for lower timeframe.
  - Minimum time frame is 2H with very high accuracy.

**Helpers**
- **Koncorde Plus**
  - Used to identify sections trend.
  - Used to identify reversals by sudden momentum, accurate.
  - Accurate in higher time-frame minimum of 30 minutes.
- **Hull Suite**
  - Any timeframe but mostly accurate in 30 minutes+.
  - Used to identify overall flow of trend.
  - Acts as resistance and support.
- **Machine Learning: Lorentzian Classification (jdehorty)**
  - Minimum timeframe 15 minutes, 30 minutes is nicer.
  - Acts as resistance and support.
  - Used to identify overall flow of trend.
  - Uses machine learning.

## Suspicious
### High Volume MA, Opposite Volume
When you see more red volume but the Moving Average (MA) is still high/up, it usually means the market is pulling back inside an uptrend, not necessarily reversing.

**Pullback in an Uptrend**
- MA high/upward = overall trend is bullish.
- Red volume = sellers active temporarily.