Cell counts and longest topological paths after mapping with Yosys.

# Decoder synthesis statistics

## Decoder synthesis statistics by design and XLEN

### `hilewitz_decoder`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 162 | 7 | 14 | 2 | 13 | 2 |
| 16 | 562 | 15 | 47 | 6 | 38 | 3 |
| 32 | 1844 | 32 | 157 | 12 | 135 | 7 |
| 64 | 5276 | 65 | 428 | 23 | 365 | 14 |

### `clairexen_bmgf_decoder`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 204 | 6 | 14 | 2 | 12 | 2 |
| 16 | 694 | 15 | 57 | 6 | 47 | 3 |
| 32 | 2008 | 30 | 173 | 11 | 150 | 7 |
| 64 | 5482 | 62 | 468 | 22 | 434 | 13 |

### `clairexen_bmext_decoder`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 328 | 11 | 30 | 4 | 24 | 2 |
| 16 | 984 | 20 | 89 | 8 | 79 | 5 |
| 32 | 2598 | 37 | 237 | 13 | 219 | 9 |
| 64 | 6692 | 71 | 670 | 25 | 583 | 16 |

## Decoder synthesis statistics by XLEN and design

## `XLEN=8` (`XLOG2=3`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 162 | 7 | 14 | 2 | 13 | 2 |
| clairexen_bmgf_decoder | 204 | 6 | 14 | 2 | 12 | 2 |
| clairexen_bmext_decoder | 328 | 11 | 30 | 4 | 24 | 2 |

## `XLEN=16` (`XLOG2=4`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 562 | 15 | 47 | 6 | 38 | 3 |
| clairexen_bmgf_decoder | 694 | 15 | 57 | 6 | 47 | 3 |
| clairexen_bmext_decoder | 984 | 20 | 89 | 8 | 79 | 5 |

## `XLEN=32` (`XLOG2=5`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 1844 | 32 | 157 | 12 | 135 | 7 |
| clairexen_bmgf_decoder | 2008 | 30 | 173 | 11 | 150 | 7 |
| clairexen_bmext_decoder | 2598 | 37 | 237 | 13 | 219 | 9 |

## `XLEN=64` (`XLOG2=6`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 5276 | 65 | 428 | 23 | 365 | 14 |
| clairexen_bmgf_decoder | 5482 | 62 | 468 | 22 | 434 | 13 |
| clairexen_bmext_decoder | 6692 | 71 | 670 | 25 | 583 | 16 |

# BM*-Func synthesis statistics

## BM*-Func synthesis statistics by design and XLEN

### `bmgf`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 444 | 9 | 37 | 4 | 27 | 3 |
| 16 | 1362 | 18 | 122 | 8 | 89 | 5 |
| 32 | 3648 | 35 | 331 | 14 | 275 | 9 |
| 64 | 9390 | 69 | 866 | 26 | 705 | 16 |

### `bmsf`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 450 | 8 | 34 | 4 | 24 | 3 |
| 16 | 1364 | 17 | 112 | 8 | 99 | 5 |
| 32 | 3802 | 33 | 304 | 14 | 273 | 9 |
| 64 | 9346 | 65 | 815 | 25 | 724 | 15 |

### `bmext`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 406 | 9 | 36 | 5 | 26 | 3 |
| 16 | 1308 | 18 | 122 | 8 | 90 | 5 |
| 32 | 3552 | 35 | 325 | 14 | 262 | 9 |
| 64 | 9192 | 69 | 885 | 26 | 717 | 16 |

### `bmdep`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 450 | 9 | 29 | 4 | 23 | 3 |
| 16 | 1458 | 17 | 106 | 8 | 84 | 5 |
| 32 | 3880 | 33 | 319 | 14 | 281 | 9 |
| 64 | 9614 | 65 | 847 | 25 | 718 | 15 |

### `bmext_omega`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 406 | 9 | 36 | 5 | 26 | 3 |
| 16 | 1308 | 18 | 122 | 8 | 90 | 5 |
| 32 | 3552 | 35 | 325 | 14 | 262 | 9 |
| 64 | 9192 | 69 | 885 | 26 | 717 | 16 |

### `bmext_shift`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 436 | 10 | 35 | 4 | 24 | 3 |
| 16 | 1454 | 19 | 120 | 9 | 90 | 5 |
| 32 | 3922 | 37 | 345 | 14 | 275 | 9 |
| 64 | 9970 | 70 | 995 | 26 | 763 | 16 |

### `bmext_hilewitz`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 400 | 9 | 36 | 5 | 25 | 3 |
| 16 | 1218 | 18 | 112 | 8 | 78 | 5 |
| 32 | 3246 | 35 | 313 | 15 | 247 | 9 |
| 64 | 9052 | 68 | 826 | 31 | 666 | 17 |

## BM*-Func synthesis statistics by XLEN and design

## `XLEN=8` (`XLOG2=3`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 444 | 9 | 37 | 4 | 27 | 3 |
| bmsf | 450 | 8 | 34 | 4 | 24 | 3 |
| bmext | 406 | 9 | 36 | 5 | 26 | 3 |
| bmdep | 450 | 9 | 29 | 4 | 23 | 3 |
| bmext_omega | 406 | 9 | 36 | 5 | 26 | 3 |
| bmext_shift | 436 | 10 | 35 | 4 | 24 | 3 |
| bmext_hilewitz | 400 | 9 | 36 | 5 | 25 | 3 |

## `XLEN=16` (`XLOG2=4`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 1362 | 18 | 122 | 8 | 89 | 5 |
| bmsf | 1364 | 17 | 112 | 8 | 99 | 5 |
| bmext | 1308 | 18 | 122 | 8 | 90 | 5 |
| bmdep | 1458 | 17 | 106 | 8 | 84 | 5 |
| bmext_omega | 1308 | 18 | 122 | 8 | 90 | 5 |
| bmext_shift | 1454 | 19 | 120 | 9 | 90 | 5 |
| bmext_hilewitz | 1218 | 18 | 112 | 8 | 78 | 5 |

## `XLEN=32` (`XLOG2=5`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 3648 | 35 | 331 | 14 | 275 | 9 |
| bmsf | 3802 | 33 | 304 | 14 | 273 | 9 |
| bmext | 3552 | 35 | 325 | 14 | 262 | 9 |
| bmdep | 3880 | 33 | 319 | 14 | 281 | 9 |
| bmext_omega | 3552 | 35 | 325 | 14 | 262 | 9 |
| bmext_shift | 3922 | 37 | 345 | 14 | 275 | 9 |
| bmext_hilewitz | 3246 | 35 | 313 | 15 | 247 | 9 |

## `XLEN=64` (`XLOG2=6`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 9390 | 69 | 866 | 26 | 705 | 16 |
| bmsf | 9346 | 65 | 815 | 25 | 724 | 15 |
| bmext | 9192 | 69 | 885 | 26 | 717 | 16 |
| bmdep | 9614 | 65 | 847 | 25 | 718 | 15 |
| bmext_omega | 9192 | 69 | 885 | 26 | 717 | 16 |
| bmext_shift | 9970 | 70 | 995 | 26 | 763 | 16 |
| bmext_hilewitz | 9052 | 68 | 826 | 31 | 666 | 17 |

