# EverCam Subtitle Player

**EverCam 字幕播放器（非官方）**

讓 EverCam 匯出的網頁課程影片快速支援 SRT、VTT、多國語字幕與現代化響應式播放器。

專案網址：[https://github.com/kaoshou/evercam-subtitle-player](https://github.com/kaoshou/evercam-subtitle-player)

## 專案緣由

起因是在使用 EverCam 錄製數位課程後，希望為匯出的網頁版課程加入字幕，卻發現原始播放器無法直接掛載 SRT 或 VTT 字幕，也缺少多國語字幕切換功能。為了讓教師不必重新剪輯影片、不必學習複雜的網頁技術，也能快速製作具有字幕與章節索引的數位教材，因此建立了 EverCam Subtitle Player。

本專案的目標是讓教師只需「放入字幕、選擇課程資料夾」兩個動作，就能完成可離線使用的字幕課程網頁。

## 商標與免責聲明

EverCam 為其權利人所有之商標。本專案名稱中的「EverCam」僅用於客觀說明適用對象及相容用途，並非用來表示本專案的商品或服務來源。

本專案由崑山科技大學鄭郁翰開發，屬非官方開源輔助工具，與 EverCam 的開發商、經銷商及商標權人之間不存在隸屬、授權、贊助、合作或背書關係。專案中不使用 EverCam 官方標誌，也不宣稱為官方外掛或官方播放器。

本專案不包含或重新散布 EverCam 軟體、授權金鑰或原廠專有程式。工具依「現況」提供，不保證與所有 EverCam 版本或匯出格式相容；使用者應保留原始課程備份，並自行確認對影片、字幕及教材內容具有合法使用權。

詳見 [`商標與免責聲明.txt`](商標與免責聲明.txt)。

## 執行畫面

以下為 EverCam Subtitle Player 在桌機瀏覽器執行的實際畫面，左側為課程影片與播放器控制列，右側保留 EverCam 章節索引。

![EverCam Subtitle Player 桌機版執行畫面](docs/images/player-desktop.png)

## 主要功能

- 支援 SRT 與 WebVTT（VTT）字幕。
- 支援多國語字幕切換。
- 保留 EverCam 的課程名稱、封面、影片及章節索引。
- 響應式設計，可在桌機、平板及手機使用。
- 支援播放速度 `0.25×` 至 `2×`。
- 使用播放器自有字幕顯示層，支援可立即生效的字級、顯示樣式與位置設定。
- 章節索引與播放器等高，索引內容可獨立捲動。
- 支援全螢幕及瀏覽器子母畫面；跨網域 iframe 禁止原生全螢幕時，會自動改為占滿 iframe。
- 可直接離線開啟，不需安裝網站伺服器。
- 不會將影片、字幕或觀看資料上傳至外部服務。

## 最簡單的使用方式

先下載並解壓縮 `evercam-subtitle-player-v版本.zip`。解壓後的安裝套件應保持以下結構，不要先把其中的檔案拆開：

```text
evercam-subtitle-player-v版本/
├─ 安裝字幕播放器.cmd
├─ player/
└─ scripts/
```

EverCam 課程資料夾則是另一個資料夾，裡面原本就有：

```text
你的課程資料夾/
├─ media.mp4
├─ config.js
├─ index.html
└─ cover.jpg                 可能有此檔案
```

### 到底要把什麼放進影片目錄？

使用推薦的一鍵安裝時，你只需要把字幕檔放進 EverCam 課程資料夾，也就是與 `media.mp4` 放在同一層。播放器檔案會由安裝工具自動複製，不需要自己搬動。

請不要把 `安裝字幕播放器.cmd` 單獨複製進課程資料夾；它必須和安裝套件內的 `player`、`scripts` 資料夾保持在一起。

### 步驟一：放入字幕

將字幕放進 EverCam 匯出的課程資料夾，也就是與 `media.mp4` 相同的位置，並依下列格式命名：

```text
subtitle.語言代碼.srt
subtitle.語言代碼.vtt
```

例如：

```text
subtitle.zh-TW.srt
subtitle.en.vtt
subtitle.ja.srt
```

同一種語言只能保留一個字幕檔。例如，不可同時放置 `subtitle.en.srt` 與 `subtitle.en.vtt`。

字幕檔建議使用 UTF-8 編碼。

### 步驟二：雙擊安裝

回到剛才解壓縮的安裝套件資料夾，雙擊：

```text
安裝字幕播放器.cmd
```

安裝精靈會顯示「準備字幕、選擇課程、開始安裝」三步驟。可直接在文字欄按 `Ctrl+V` 貼上已複製的完整路徑，也可以按「貼上路徑」或「瀏覽資料夾…」。視窗顯示綠色的「可以安裝」狀態後，再按「開始安裝」。工具會自動：

![EverCam Subtitle Player 三步驟安裝精靈](docs/images/installer-wizard.png)

上圖為 Windows 安裝精靈。先依步驟 1 將字幕放進課程資料夾，再於步驟 2 貼上或選擇該資料夾；系統確認找到 `media.mp4` 與 `config.js` 後，步驟 3 的「開始安裝」按鈕便可使用。

1. 檢查資料夾內是否有 `media.mp4` 與 `config.js`。
2. 備份原始 `index.html` 為 `index.evercam-original.html`。
3. 安裝新版播放器並掃描 SRT／VTT 字幕。
4. 開啟完成的課程。

也可以把 EverCam 課程資料夾直接拖曳到 `安裝字幕播放器.cmd`，不必再從視窗選擇。

以後新增或修改字幕，只要再次雙擊 `更新字幕.cmd` 即可。

### 安裝完成後的課程資料夾

安裝工具會自動形成以下結構。標示「原有」的檔案請保留；其餘播放器檔案不需手動複製。

```text
你的課程資料夾/
├─ media.mp4                       EverCam 原有影片
├─ config.js                       EverCam 原有課程與章節設定
├─ cover.jpg                       EverCam 原有封面（若有）
├─ index.evercam-original.html     原始首頁備份
├─ index.html                      新版播放器
├─ subtitle.zh-TW.srt              你放入的字幕，可有多個語言
├─ subtitles-data.js               工具自動產生
├─ 更新字幕.cmd                    以後更新字幕時雙擊
├─ 字幕使用說明.txt
├─ css/
├─ js/
└─ tools/
```

## 手動安裝（進階）

若不使用一鍵工具，只能複製 [`player`](player/) **裡面的內容**到 EverCam 課程資料夾，不是複製整個 `player` 資料夾。需要複製的是：

```text
index.html
subtitles-data.js
更新字幕.cmd
字幕使用說明.txt
css/
js/
tools/
```

將上述內容放到與 `media.mp4`、`config.js` 相同的位置，取代原本的 `index.html`，再雙擊 `更新字幕.cmd`。

請勿刪除 EverCam 原本的 `media.mp4`、`config.js` 與封面檔；播放器會從 `config.js` 讀取課程名稱、影片路徑與章節資料。

## 常用語言代碼

本專案使用 BCP 47 語言標籤。一般語言只需使用簡短代碼；需要區分文字系統或地區時，再加上第二段標籤。

| 語言 | 建議代碼 | 字幕檔名範例 |
|---|---|---|
| 正體中文（臺灣） | `zh-TW` | `subtitle.zh-TW.srt` |
| 正體中文（不限定地區） | `zh-Hant` | `subtitle.zh-Hant.srt` |
| 簡體中文（中國大陸） | `zh-CN` | `subtitle.zh-CN.srt` |
| 簡體中文（不限定地區） | `zh-Hans` | `subtitle.zh-Hans.srt` |
| 英文 | `en` | `subtitle.en.vtt` |
| 日文 | `ja` | `subtitle.ja.srt` |
| 韓文 | `ko` | `subtitle.ko.vtt` |
| 越南文 | `vi` | `subtitle.vi.srt` |
| 印尼文 | `id` | `subtitle.id.srt` |
| 西班牙文 | `es` | `subtitle.es.vtt` |
| 法文 | `fr` | `subtitle.fr.srt` |
| 德文 | `de` | `subtitle.de.vtt` |
| 泰文 | `th` | `subtitle.th.srt` |
| 馬來文 | `ms` | `subtitle.ms.vtt` |

更多語言標籤可參考：

- [W3C：Choosing a language tag](https://www.w3.org/International/questions/qa-choosing-language-tags)
- [IANA Language Subtag Registry](https://www.iana.org/assignments/language-subtags-tags-extensions/language-subtags-tags-extensions.xhtml)

## 學生端操作

- 點擊章節可跳到對應時間。
- 從播放器的 `CC` 按鈕切換字幕語言或關閉字幕。
- 從 `CC → 字幕外觀` 調整字幕大小、顏色與位置。
- 使用速度選單切換慢速、正常或快速播放。
- 瀏覽器支援時，可使用子母畫面。

桌機鍵盤快捷鍵：

| 按鍵 | 功能 |
|---|---|
| `Space` | 播放／暫停 |
| `←`／`→` | 倒退／快轉 10 秒 |
| `M` | 靜音／恢復聲音 |
| `F` | 進入／離開全螢幕 |

## 專案結構

```text
evercam-subtitle-player/
├─ README.md
├─ CHANGELOG.md
├─ VERSION
├─ 安裝字幕播放器.cmd          教師使用的一鍵安裝入口
├─ 快速使用說明.txt
├─ 商標與免責聲明.txt
├─ docs/images/                  README 使用的實際執行畫面
├─ player/                       可直接複製給教師使用的播放器
│  ├─ index.html
│  ├─ subtitles-data.js
│  ├─ 更新字幕.cmd
│  ├─ 字幕使用說明.txt
│  ├─ css/evercam-modern.css
│  ├─ js/evercam-modern.js
│  └─ tools/Build-Subtitles.ps1
├─ examples/                     字幕命名與格式範例
└─ scripts/
   ├─ Install-Player.ps1         一鍵安裝核心
   └─ Build-Release.ps1          建立發佈用 ZIP
```

實際課程的 `media.mp4`、`config.js`、封面及字幕不應提交到本專案儲存庫。

## 建立發佈套件

專案維護者可在 Windows PowerShell 執行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Build-Release.ps1
```

完成後會在 `release` 資料夾產生可供教師下載的一鍵安裝 ZIP。發佈時，教師只需下載並解壓縮這個檔案，不需要下載整份原始碼。


## 系統需求

- 教師製作端：Windows 10 或 Windows 11。
- 學生播放端：支援 HTML5 Video 的現代瀏覽器。
- 子母畫面是否出現，由瀏覽器及作業系統支援狀況決定。
