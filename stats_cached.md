Cell counts and longest topological paths after mapping with Yosys.

# Decoder synthesis statistics

## Decoder synthesis statistics by design and XLEN

### `hilewitz_decoder`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 166 | 7 | 14 | 2 | 13 | 2 |
| 16 | 570 | 16 | 47 | 6 | 38 | 3 |
| 32 | 1898 | 35 | 167 | 12 | 123 | 8 |
| 64 | 5288 | 66 | 430 | 24 | 367 | 15 |

## Decoder synthesis statistics by XLEN and design

## `XLEN=8` (`XLOG2=3`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 166 | 7 | 14 | 2 | 13 | 2 |
| clairexen_bmgf_decoder | 204 | 6 | 14 | 2 | 12 | 2 |
| clairexen_bmext_decoder | 318 | 9 | 30 | 4 | 24 | 2 |

## `XLEN=16` (`XLOG2=4`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 570 | 16 | 47 | 6 | 38 | 3 |
| clairexen_bmgf_decoder | 694 | 15 | 57 | 6 | 47 | 3 |
| clairexen_bmext_decoder | 962 | 19 | 87 | 7 | 78 | 4 |

## `XLEN=32` (`XLOG2=5`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 1898 | 35 | 167 | 12 | 123 | 8 |
| clairexen_bmgf_decoder | 2008 | 30 | 173 | 11 | 150 | 7 |
| clairexen_bmext_decoder | 2568 | 37 | 241 | 14 | 210 | 8 |

## `XLEN=64` (`XLOG2=6`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 5288 | 66 | 430 | 24 | 367 | 15 |
| clairexen_bmgf_decoder | 5482 | 62 | 468 | 22 | 434 | 13 |
| clairexen_bmext_decoder | 6554 | 70 | 689 | 25 | 572 | 15 |

