
# Blueprint: 鼎鼎無名的占卜小館

## 總覽

這是一款提供多樣化神秘學工具的行動應用程式，旨在引導使用者進行自我探索。應用程式整合了塔羅牌、占星術和心理測驗，並提供一個深度的 VIP 諮詢服務入口。整體風格為現代、神秘且直觀的暗黑模式設計。

## 最終風格、設計與功能

### **1. 整體主題 (Theming)**

*   **強制暗黑模式**: 為了營造神秘、沉浸的體驗，應用程式在 `main.dart` 中強制設定 `themeMode: ThemeMode.dark`。
*   **核心配色**:
    *   背景: 深灰/黑色系。
    *   主色調: 根據 Material 3 的 `ColorScheme.fromSeed`，以 `Colors.deepPurple` 為種子色生成，創造出和諧且帶有神秘感的紫色系。
    *   卡片與容器: 使用 `secondaryContainer` 等顏色，提供柔和的對比。

### **2. 路由與導航 (Routing)**

*   **GoRouter**: 採用 `go_router` 進行聲明式路由管理，確保了清晰的導航結構和對 Web 的良好支援。
*   **已定義路由**:
    *   `/`: 主畫面 (`HomeScreen`)
    *   `/tarot-daily`: 每日塔羅 (`TarotDailyScreen`)
    *   `/astrology-trinity`: 占星三星牌 (`AstrologyTrinityDrawScreen`)
    *   `/psych-test`: 心理測驗 (`PsychTestListScreen`)
    *   `/vip-service`: VIP 深度解析 (`VipServiceScreen`)
    *   `/season-spread`: 四季牌陣 (`SeasonSpreadScreen`)

### **3. 主畫面 (`HomeScreen`)**

*   **網格佈局 (`GridView`)**: 主畫面使用 `GridView.count` 建立一個 2x2 的網格，用於展示核心功能。
*   **功能卡片**: 每個功能入口都是一個帶有 `Icon` 和 `Text` 的 `Card`，設計直觀且易於點擊。
*   **VIP 服務入口**: 在網格下方有一個獨立的橫幅式按鈕，用於引導至 VIP 深度解析服務。

### **4. 功能模組詳解**

#### **每日塔羅 (`TarotDailyScreen`)**

*   **後端整合**: 連接 Firebase 的 `tarot_cards` 集合。
*   **抽牌邏輯**:
    1.  點擊「抽三張牌」按鈕。
    2.  從 Firestore 中隨機抽取 3 張不重複的塔羅牌。
    3.  為每張牌隨機決定「正位」或「逆位」。
*   **結果展示**:
    *   以列表形式展示每張牌。
    *   顯示牌名、正逆位狀態。
    *   根據正逆位顯示對應的解讀文字 (`uprightText_zh` 或 `reversedText_zh`)。
    *   提供愛情、事業、財務的簡短建議。
*   **深度引導**: 包含一個導向「四季牌陣」畫面的橫幅，鼓勵使用者進行更深入的探索。

#### **占星三星牌 (`AstrologyTrinityDrawScreen`)**

*   **後端整合**: 連接 Firebase 的 `planets`, `houses`, `signs` 三個集合。
*   **抽牌邏輯**:
    1.  點擊「抽三星牌」按鈕。
    2.  從三個集合中各隨機抽取一張牌。
*   **結果展示**:
    *   頂部並排顯示三張卡片（行星、宮位、星座）。
    *   中央顯示一句整合性的話語，例如：「"太陽" 在 "第一宮"，以 "牡羊座" 的方式呈現。」
    *   下方詳細列出每張牌的完整解讀 (`full_description_zh`) 和建議 (`advice_zh`)。

#### **心理測驗 (`PsychTestListScreen`)**

*   **前端邏輯**: 這是一個輕量級的前端互動測驗。
*   **互動流程**:
    1.  提出一個問題。
    2.  提供四個選項按鈕。
    3.  使用者點擊選項後，在下方卡片中顯示對應的結果文字。
*   **分享功能**: 包含一個分享圖示，為未來擴充功能預留。

#### **四季牌陣 (`SeasonSpreadScreen`)**

*   **服務說明頁**: 這是一個靜態頁面，用於解釋「四季牌陣」是一項專業的付費諮詢服務。
*   **外部連結**: 包含一個「聯繫老師預約抽牌」的按鈕，使用 `url_launcher` 套件，未來可跳轉至指定的預約網頁。

#### **VIP 深度解析 (`VipServiceScreen`)**

*   **佔位頁面**: 一個簡單的頁面，表明此處將提供 VIP 專屬服務，為未來的擴充留下入口。

## 最終實施總結

*   **任務完成**: 已根據使用者提供的最終施工圖，完成所有 UI 畫面和核心功能開發。
*   **檔案建立**: 成功創建了 `astrology_trinity_draw_screen.dart`, `psych_test_list_screen.dart`, `season_spread_screen.dart`, `tarot_daily_screen.dart`, `vip_service_screen.dart` 等檔案。
*   **後端整合**: 成功使用 `cloud_firestore` 套件實現了「每日塔羅」和「占星三星牌」的動態抽牌功能。
*   **導航實現**: 使用 `go_router` 重新構建了應用程式的導航系統。
*   **程式碼上傳**: 所有本地變更已提交並成功推送到指定的 GitHub 儲存庫。
*   **專案狀態**: 應用程式目前處於一個功能完整、設計一致的穩定版本。
