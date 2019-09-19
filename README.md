# JP Medical Recept Reader

Emacs Reader of *レセプト電算ファイル* with posframe.  
[社会保険診療報酬支払基金 | レセプト電算処理システム](https://www.ssk.or.jp/seikyushiharai/rezept/)

[![Image from Gyazo](https://i.gyazo.com/78de04079cf4fab47e1f9bd7c8f35636.png)](https://gyazo.com/78de04079cf4fab47e1f9bd7c8f35636)

## Setup

### Requrements

This package use [posframe](https://github.com/tumashu/posframe), and [dash.el](https://github.com/magnars/dash.el)  
You need to install it beforehand.

### Settings

`git clone` and edit your init.el as below.

```elisp
(add-to-list 'load-path "YOUR PATH")
(require 'jp-medical-recept-reader)
```

## Usage

1. Open *.UKE file
2. Set the cursor on the records
3. `M-x recept-info-toggle`
4. Close by `M-x recept-info-toggle` again
