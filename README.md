# Einstein — 愛因斯坦互動傳記

一款以 Albert Einstein（阿爾伯特・愛因斯坦）為主題的 SwiftUI 互動傳記 App。透過人物資料、原始論文、理論推導、生平時間線與世界地圖，探索愛因斯坦的一生及其科學成就。

## 主要功能

- 人物生平與重要資料介紹
- 經典科學論文導讀
- 相對論等重要理論的互動式推導
- 生平事件時間線
- 世界地圖與相關地點
- 支援淺色、深色與系統外觀
- 可縮放、拖曳的人物圖片
- VoiceOver 無障礙標籤與操作提示
- 內建中文與英文字型

## 使用技術

- Swift
- SwiftUI
- MapKit
- LaTeX 風格數學公式排版
- SF Symbols

## 如何執行

1. 下載或 Clone 此 Repository。
2. 使用 Xcode 開啟 `Untitled Project 2.xcodeproj`。
3. 選擇可用的 iPhone Simulator 或實體裝置。
4. 按下 **Run**（`Command + R`）。

## 專案結構

- `ContentView.swift`：主畫面與章節導覽
- `EinsteinModels.swift`：人物與時間線資料模型
- `EinsteinPaperModels.swift`：科學論文資料模型
- `EinsteinTheoryModels.swift`：理論資料模型
- `ScientificPaperViews.swift`：論文內容畫面
- `TheoryDerivationViews.swift`：理論推導畫面
- `EinsteinMapView.swift`：地圖畫面
- `EinsteinTypography.swift`：字型與排版設定
- `LaTeXText.swift`：數學公式顯示元件

## 字型授權

專案包含第三方字型。相關授權資訊請參閱 `MyApp/Fonts/CNS11643-FONT-LICENSE.md`；使用或重新散布前，請同時確認其他內附字型各自的授權條款。

## License

此專案尚未指定程式碼授權條款。若要公開供他人使用或修改，建議另外加入合適的 `LICENSE` 檔案。
