# Oscars Data Warehouse

## Project Files

| File | Description |
|---|---|
| `01_load.sql` | Load staging data from `oscars.csv` |
| `02_create_load_tables.sql` | Operational schema + ETL + Dimensions, facts, snapshots |
| `03_teste_queries.sql` | Analytical queries |
| `oscars.csv` | Source dataset (~10k rows) |

---

## Query Analysis

The dataset covers **96 Oscar ceremonies** from 1927/28 to 2023, with a total of **11,874 nominations** and **3,435 winners**.

---

### Q1 & Q2 — Overall Scale

The dataset contains 11,874 nominations across all ceremonies, of which 3,435 resulted in a win. That's roughly a 29% overall win rate — which makes sense given that most categories have around 5 nominees per year.

---

### Q3 — Most Nominated Films

| Title | Nominations |
|---|---|
| A Star Is Born | 26 |
| West Side Story | 18 |
| Titanic | 16 |
| Mutiny on the Bounty | 15 |
| Moulin Rouge | 15 |
| Gone with the Wind | 15 |
| Little Women | 14 |
| La La Land | 14 |
| Cleopatra | 14 |
| All about Eve | 14 |

*A Star Is Born* tops the list with 26 nominations — but it's been remade multiple times (1937, 1954, 1976, 2018), so those nominations are accumulated across versions. Titanic and Gone with the Wind stand out as single-release films with exceptional nomination counts.

---

### Q4 — Most Nominated Categories

| Category | Nominations |
|---|---|
| BEST PICTURE | 601 |
| MUSIC (Original Score) | 519 |
| MUSIC (Original Song) | 475 |
| DIRECTING | 471 |
| FILM EDITING | 450 |
| ACTRESS IN A SUPPORTING ROLE | 440 |
| ACTOR IN A SUPPORTING ROLE | 440 |
| WRITING (Original Screenplay) | 415 |
| SHORT FILM (Animated) | 393 |
| DOCUMENTARY (Short Subject) | 387 |

Best Picture leads as expected — it's the most prestigious and has existed since the very first ceremony. Music categories rank surprisingly high, reflecting how many films compete each year for score and song.

---

### Q5 — Wins by Year (Top 10)

| Year | Wins |
|---|---|
| 1998 | 62 |
| 1994 | 53 |
| 2001 | 52 |
| 1995 | 51 |
| 2014 | 50 |

1998 is the standout year — Titanic alone won 11 Oscars that night, but the high total also reflects the Academy expanding the number of categories over the decades. The 1990s and 2000s consistently show high win totals compared to earlier decades.

---

### Q6 — Distinct Nominees by Class

| Class | Distinct Nominees |
|---|---|
| Production | 2123 |
| Title | 2049 |
| Acting | 980 |
| SciTech | 872 |
| Writing | 829 |
| Music | 650 |
| Special | 341 |
| Directing | 278 |

Production and Title classes involve the most unique people — Production covers cinematography, editing, art direction, and costumes, all of which involve large crews. Directing is the most exclusive class, with just 278 distinct nominees across nearly 100 years.

---

### Q8 — Most Nominated Films with Win Rate

| Title | Nominations | Wins | Win Rate |
|---|---|---|---|
| A Star Is Born | 26 | 4 | 15.4% |
| West Side Story | 18 | 11 | 61.1% |
| Titanic | 16 | 12 | 75.0% |
| Mutiny on the Bounty | 15 | 1 | 6.7% |
| Gone with the Wind | 15 | 10 | 66.7% |

This is where things get interesting. Titanic has a 75% win rate — one of the most efficient award-night performances in Oscar history. Mutiny on the Bounty, on the other hand, had 15 nominations and won just once. *A Star Is Born* accumulated many nominations but wins remain modest across its remakes.

---

### Q9 — Nominations by Decade

| Decade | Nominations | Wins |
|---|---|---|
| 1920s | 133 | 33 |
| 1930s | 866 | 227 |
| 1940s | 1528 | 343 |
| 1950s | 1259 | 355 |
| 1960s | 1235 | 328 |
| 1970s | 1152 | 345 |
| 1980s | 1182 | 381 |
| 1990s | 1320 | 460 |
| 2000s | 1288 | 411 |
| 2010s | 1394 | 421 |
| 2020s | 517 | 131 |

The 1940s saw a big jump in nominations — largely due to the Academy expanding categories and the wartime boom in documentary filmmaking. The 2020s are still incomplete (only 2020–2023 in the dataset), which explains the lower numbers.

---

### Q10 — Peak Years per Category

| Year | Category | Nominations |
|---|---|---|
| 1942 | DOCUMENTARY (Feature) | 25 |
| 1945 | MUSIC (Original Score) | 21 |
| 1941 | MUSIC (Original Score) | 20 |
| 1943 | DOCUMENTARY (Short Subject) | 20 |

The early 1940s dominate — WWII drove a massive surge in documentary production and patriotic film scores. These were years where the Academy had very loose limits on how many films could be nominated per category, explaining the unusually high counts.

---

### Q11 — Top Categories by Win Rate

| Category | Nominations | Wins | Win Rate |
|---|---|---|---|
| BEST PICTURE | 601 | 96 | 16.0% |
| MUSIC (Original Score) | 519 | 85 | 16.4% |
| DIRECTING | 471 | 95 | 20.2% |
| FILM EDITING | 450 | 90 | 20.0% |

Most major categories hover around 20% win rate, which reflects the standard 5-nominee shortlist. Best Picture is slightly lower at 16% — historically it's had more nominees per year, especially after the Academy expanded to up to 10 nominees in 2010.

---

### Q12 — Creative vs Technical Classes

| Class Group | Class | Nominations | Wins | Win Rate |
|---|---|---|---|---|
| Technical | Production | 3222 | 683 | 21.2% |
| Creative | Title | 2706 | 572 | 21.1% |
| Creative | Acting | 1835 | 373 | 20.3% |
| Technical | SciTech | 890 | 890 | 100.0% |
| Creative | Special | 376 | 370 | 98.4% |

The 100% win rate for SciTech is not a data error — Scientific and Technical Awards are honorary, given to everyone selected by a special committee. They're not competitive in the traditional sense, which is why every nominee wins. The same logic applies to Special Awards.

---

### Q13 — Most Winning Nominees

| Name | Nominations | Wins | Win Rate |
|---|---|---|---|
| Walt Disney, Producer | 62 | 25 | 40.3% |
| Eastman Kodak Company | 15 | 15 | 100.0% |
| Metro-Goldwyn-Mayer | 68 | 13 | 19.1% |
| Alfred Newman | 34 | 7 | 20.6% |

Walt Disney leads all individuals with 25 wins, largely through his short films and animated features in the 1930s–1950s. Eastman Kodak's 100% rate reflects their multiple Scientific and Technical Awards. MGM's nominations span decades of studio-era dominance.

---

### Q14 — Top Films by Class

| Class | Title | Nominations | Wins |
|---|---|---|---|
| Acting | A Star Is Born | 7 | 0 |
| Acting | On the Waterfront | 5 | 2 |
| Acting | Network | 5 | 3 |

*A Star Is Born* accumulated 7 acting nominations across its versions without a single acting win — a remarkable record of near-misses. Network (1976) stands out with 3 wins from 5 acting nominations, one of the strongest acting nights in Oscar history.

---

### Q15 — Classic vs Modern Era

| Era | Nominations | Wins | Distinct Films | Distinct Nominees | Win Rate |
|---|---|---|---|---|---|
| classic (pre-2000) | 8677 | 2472 | 4691 | 5489 | 28.5% |
| modern (2000+) | 3199 | 963 | 1713 | 2562 | 30.1% |

The classic era naturally dominates in raw volume — it spans over 70 years versus around 23 for the modern era. What's interesting is that the modern era has a slightly higher win rate (30.1% vs 28.5%), which could reflect the Academy standardising category sizes more strictly in recent decades. The classic era also shows greater diversity in nominees, with 5,489 distinct nominees across a wider range of category types that no longer exist today.
