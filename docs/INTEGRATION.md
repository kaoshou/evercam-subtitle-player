# 播放器整合紀錄

日期：2026-10-24。版本：1.1.0。

來源：kaoshou/Video-to-Subtitle 的 v2.8.3，提交 c167601。
移植 assets/evercam_player 的 index.html、css/evercam-modern.css、js/evercam-modern.js。
來源仍保留本專案作者與專案網址註解。

沿用來源的章節／逐字稿分頁、搜尋高亮、點擊跳轉、多語切換、分頁、選用的跟隨播放、閱讀字級／行距／高對比，以及 HTML／TXT 完整逐字稿下載。保留本專案 Windows 安裝與字幕轉換流程，不加入 Python 或語音轉寫相依套件。

開發相依套件僅用於驗證，不放入使用者 ZIP。tests/fixtures/standalone.html 是來源共用程式的一般 MP4 回歸測試範本，並非此專案新增的安裝模式。

## 本機驗證

- npm test：37 項通過。
- node --check player/js/evercam-modern.js：通過。
- Chromium 原生影片播放測試：EverCam／共用一般 MP4 範本，各桌面與手機，共 4 組、72 項檢查通過。
- axe-core：0 條違規，40 筆待人工判讀結果；詳見 test-results/accessibility/report.json（不納入 Git）。
- 從 v1.1.0 ZIP 解壓後，執行安裝器至合成課程：成功產生 zh-TW 字幕，3 段 cues。
- 安裝後的 JavaScript 與來源 SHA-256 一致。
- git diff --check：通過。

預覽：test-results/install-course/index.html，使用合成影片與測試字幕，不包含真實課程。

尚未驗證 NVDA／VoiceOver 實際朗讀、Firefox／Safari 與實體手機，不宣稱全面符合 AA。
