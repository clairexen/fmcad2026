Cell counts and longest topological paths after mapping with Yosys.

# Decoder post-synthesis statistics

## Decoder post-synthesis statistics by design and XLEN

### `hilewitz_decoder`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 162 | 7 LTP | 14 | 2 LTP | 13 | 2 LTP |
| 16 | 562 | 15 LTP | 47 | 6 LTP | 38 | 3 LTP |
| 32 | 1844 | 32 LTP | 157 | 12 LTP | 135 | 7 LTP |
| 64 | 5276 | 65 LTP | 428 | 23 LTP | 365 | 14 LTP |

### `clairexen_omega_decoder`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 204 | 6 LTP | 14 | 2 LTP | 12 | 2 LTP |
| 16 | 694 | 15 LTP | 57 | 6 LTP | 47 | 3 LTP |
| 32 | 2008 | 30 LTP | 173 | 11 LTP | 150 | 7 LTP |
| 64 | 5482 | 62 LTP | 468 | 22 LTP | 434 | 13 LTP |

### `clairexen_shift_decoder`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 328 | 11 LTP | 30 | 4 LTP | 24 | 2 LTP |
| 16 | 984 | 20 LTP | 89 | 8 LTP | 79 | 5 LTP |
| 32 | 2598 | 37 LTP | 237 | 13 LTP | 219 | 9 LTP |
| 64 | 6692 | 71 LTP | 670 | 25 LTP | 583 | 16 LTP |

## Decoder post-synthesis statistics by XLEN and design

## `XLEN=8` (`XLOG2=3`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 162 | 7 LTP | 14 | 2 LTP | 13 | 2 LTP |
| clairexen_omega_decoder | 204 | 6 LTP | 14 | 2 LTP | 12 | 2 LTP |
| clairexen_shift_decoder | 328 | 11 LTP | 30 | 4 LTP | 24 | 2 LTP |

## `XLEN=16` (`XLOG2=4`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 562 | 15 LTP | 47 | 6 LTP | 38 | 3 LTP |
| clairexen_omega_decoder | 694 | 15 LTP | 57 | 6 LTP | 47 | 3 LTP |
| clairexen_shift_decoder | 984 | 20 LTP | 89 | 8 LTP | 79 | 5 LTP |

## `XLEN=32` (`XLOG2=5`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 1844 | 32 LTP | 157 | 12 LTP | 135 | 7 LTP |
| clairexen_omega_decoder | 2008 | 30 LTP | 173 | 11 LTP | 150 | 7 LTP |
| clairexen_shift_decoder | 2598 | 37 LTP | 237 | 13 LTP | 219 | 9 LTP |

## `XLEN=64` (`XLOG2=6`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| hilewitz_decoder | 5276 | 65 LTP | 428 | 23 LTP | 365 | 14 LTP |
| clairexen_omega_decoder | 5482 | 62 LTP | 468 | 22 LTP | 434 | 13 LTP |
| clairexen_shift_decoder | 6692 | 71 LTP | 670 | 25 LTP | 583 | 16 LTP |

# BM*-Func post-synthesis statistics

## BM*-Func post-synthesis statistics by design and XLEN

### `bmgf`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 444 | 9 LTP | 37 | 4 LTP | 27 | 3 LTP |
| 16 | 1362 | 18 LTP | 122 | 8 LTP | 89 | 5 LTP |
| 32 | 3648 | 35 LTP | 331 | 14 LTP | 275 | 9 LTP |
| 64 | 9390 | 69 LTP | 866 | 26 LTP | 705 | 16 LTP |

### `bmsf`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 450 | 8 LTP | 34 | 4 LTP | 24 | 3 LTP |
| 16 | 1364 | 17 LTP | 112 | 8 LTP | 99 | 5 LTP |
| 32 | 3802 | 33 LTP | 304 | 14 LTP | 273 | 9 LTP |
| 64 | 9346 | 65 LTP | 815 | 25 LTP | 724 | 15 LTP |

### `bmext`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 406 | 9 LTP | 36 | 5 LTP | 26 | 3 LTP |
| 16 | 1308 | 18 LTP | 122 | 8 LTP | 90 | 5 LTP |
| 32 | 3552 | 35 LTP | 325 | 14 LTP | 262 | 9 LTP |
| 64 | 9192 | 69 LTP | 885 | 26 LTP | 717 | 16 LTP |

### `bmdep`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 450 | 9 LTP | 29 | 4 LTP | 23 | 3 LTP |
| 16 | 1458 | 17 LTP | 106 | 8 LTP | 84 | 5 LTP |
| 32 | 3880 | 33 LTP | 319 | 14 LTP | 281 | 9 LTP |
| 64 | 9614 | 65 LTP | 847 | 25 LTP | 718 | 15 LTP |

### `bmext_omega`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 406 | 9 LTP | 36 | 5 LTP | 26 | 3 LTP |
| 16 | 1308 | 18 LTP | 122 | 8 LTP | 90 | 5 LTP |
| 32 | 3552 | 35 LTP | 325 | 14 LTP | 262 | 9 LTP |
| 64 | 9192 | 69 LTP | 885 | 26 LTP | 717 | 16 LTP |

### `bmext_shift`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 436 | 10 LTP | 35 | 4 LTP | 24 | 3 LTP |
| 16 | 1454 | 19 LTP | 120 | 9 LTP | 90 | 5 LTP |
| 32 | 3922 | 37 LTP | 345 | 14 LTP | 275 | 9 LTP |
| 64 | 9970 | 70 LTP | 995 | 26 LTP | 763 | 16 LTP |

### `bmext_hilewitz`

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 400 | 9 LTP | 36 | 5 LTP | 25 | 3 LTP |
| 16 | 1218 | 18 LTP | 112 | 8 LTP | 78 | 5 LTP |
| 32 | 3246 | 35 LTP | 313 | 15 LTP | 247 | 9 LTP |
| 64 | 9052 | 68 LTP | 826 | 31 LTP | 666 | 17 LTP |

## BM*-Func post-synthesis statistics by XLEN and design

## `XLEN=8` (`XLOG2=3`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 444 | 9 LTP | 37 | 4 LTP | 27 | 3 LTP |
| bmsf | 450 | 8 LTP | 34 | 4 LTP | 24 | 3 LTP |
| bmext | 406 | 9 LTP | 36 | 5 LTP | 26 | 3 LTP |
| bmdep | 450 | 9 LTP | 29 | 4 LTP | 23 | 3 LTP |
| bmext_omega | 406 | 9 LTP | 36 | 5 LTP | 26 | 3 LTP |
| bmext_shift | 436 | 10 LTP | 35 | 4 LTP | 24 | 3 LTP |
| bmext_hilewitz | 400 | 9 LTP | 36 | 5 LTP | 25 | 3 LTP |

## `XLEN=16` (`XLOG2=4`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 1362 | 18 LTP | 122 | 8 LTP | 89 | 5 LTP |
| bmsf | 1364 | 17 LTP | 112 | 8 LTP | 99 | 5 LTP |
| bmext | 1308 | 18 LTP | 122 | 8 LTP | 90 | 5 LTP |
| bmdep | 1458 | 17 LTP | 106 | 8 LTP | 84 | 5 LTP |
| bmext_omega | 1308 | 18 LTP | 122 | 8 LTP | 90 | 5 LTP |
| bmext_shift | 1454 | 19 LTP | 120 | 9 LTP | 90 | 5 LTP |
| bmext_hilewitz | 1218 | 18 LTP | 112 | 8 LTP | 78 | 5 LTP |

## `XLEN=32` (`XLOG2=5`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 3648 | 35 LTP | 331 | 14 LTP | 275 | 9 LTP |
| bmsf | 3802 | 33 LTP | 304 | 14 LTP | 273 | 9 LTP |
| bmext | 3552 | 35 LTP | 325 | 14 LTP | 262 | 9 LTP |
| bmdep | 3880 | 33 LTP | 319 | 14 LTP | 281 | 9 LTP |
| bmext_omega | 3552 | 35 LTP | 325 | 14 LTP | 262 | 9 LTP |
| bmext_shift | 3922 | 37 LTP | 345 | 14 LTP | 275 | 9 LTP |
| bmext_hilewitz | 3246 | 35 LTP | 313 | 15 LTP | 247 | 9 LTP |

## `XLEN=64` (`XLOG2=6`)

| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| bmgf | 9390 | 69 LTP | 866 | 26 LTP | 705 | 16 LTP |
| bmsf | 9346 | 65 LTP | 815 | 25 LTP | 724 | 15 LTP |
| bmext | 9192 | 69 LTP | 885 | 26 LTP | 717 | 16 LTP |
| bmdep | 9614 | 65 LTP | 847 | 25 LTP | 718 | 15 LTP |
| bmext_omega | 9192 | 69 LTP | 885 | 26 LTP | 717 | 16 LTP |
| bmext_shift | 9970 | 70 LTP | 995 | 26 LTP | 763 | 16 LTP |
| bmext_hilewitz | 9052 | 68 LTP | 826 | 31 LTP | 666 | 17 LTP |

# Additional post-synthesis statistics

## Relative area and LTP

### Rel. area and LTP of bmext_hilewitz wrt bmext_omega by XLEN

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 98% | 100% LTP | 100% | 100% LTP | 96% | 100% LTP |
| 16 | 93% | 100% LTP | 91% | 100% LTP | 86% | 100% LTP |
| 32 | 91% | 100% LTP | 96% | 107% LTP | 94% | 100% LTP |
| 64 | 98% | 98% LTP | 93% | 119% LTP | 92% | 106% LTP |

### Rel. area and LTP of bmext_shift wrt bmext_omega by XLEN

| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |
| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |
| 8 | 107% | 111% LTP | 97% | 80% LTP | 92% | 100% LTP |
| 16 | 111% | 105% LTP | 98% | 112% LTP | 100% | 100% LTP |
| 32 | 110% | 105% LTP | 106% | 100% LTP | 104% | 100% LTP |
| 64 | 108% | 101% LTP | 112% | 100% LTP | 106% | 100% LTP |

