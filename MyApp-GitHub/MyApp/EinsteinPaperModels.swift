import SwiftUI

struct PaperEquation: Identifiable {
    let id: String
    let equation: String
    let interpretation: String
}

struct PaperChapter: Identifiable {
    let id: String
    let title: String
    let paragraphs: [String]
    let equations: [PaperEquation]
}

struct ScientificPaper: Identifiable {
    let id: String
    let number: String
    let icon: String
    let germanTitle: String
    let chineseTitle: String
    let submitted: String
    let published: String
    let citation: String
    let doi: String
    let editorialNote: String
    let abstract: String
    let researchQuestion: String
    let argument: [String]
    let equations: [PaperEquation]
    let chapters: [PaperChapter]
    let conclusion: String
    let historicalImpact: String
    let accent: Color
}

enum EinsteinPaperContent {
    static let papers = [
        ScientificPaper(
            id: "light-quanta-1905",
            number: "PAPER 01",
            icon: "sun.max.fill",
            germanTitle: "Über einen die Erzeugung und Verwandlung des Lichtes betreffenden heuristischen Gesichtspunkt",
            chineseTitle: "關於光的產生和轉變的一個啟發性觀點",
            submitted: "1905 年 3 月 18 日",
            published: "1905 年 6 月 9 日",
            citation: "Annalen der Physik, 17, 132–148",
            doi: "10.1002/andp.19053220607",
            editorialNote: "以下依 1905 年原論文的九節架構，以現代中文與現代符號完整重述；為兼顧可讀性，符號已統一，但論證次序與物理內容保持一致。",
            abstract: "連續的 Maxwell 波動理論能精確描述光的傳播，卻難以處理黑體輻射的高頻區、光致發光、紫外光電子產生等現象。本文從 Wien 輻射定律的熵出發，證明稀薄單色輻射在熱力學上如同由互不依賴的能量單元組成，進而提出光在吸收與放射時以能量 hν 的局域量子行動。",
            researchQuestion: "黑體輻射、光致發光與光電效應中，光與物質交換能量的方式為何呈現離散特徵？",
            argument: [
                "從 Wien 高頻極限的輻射熵出發，比較單色輻射與理想氣體的體積依賴。",
                "發現輻射熵的數學形式，等同於由彼此獨立粒子組成的氣體。",
                "提出頻率為 ν 的光在吸收與放射時，表現為能量 hν 的局域量子。",
                "將能量守恆套用至金屬電子，導出光電子最大動能與頻率的線性關係。"
            ],
            equations: [
                PaperEquation(id: "l1", equation: "Eγ = hν", interpretation: "每一光量子的能量只由頻率決定。"),
                PaperEquation(id: "l2", equation: "Kₘₐₓ = hν − φ", interpretation: "光子能量扣除金屬功函數後，成為電子最大動能。")
            ],
            chapters: [
                PaperChapter(id: "l-c1", title: "一、連續理論的限制", paragraphs: [
                    "經典電磁理論把光場視為連續分布於空間的能量。這對干涉、繞射與傳播極為成功；然而光的產生與物質交換能量時，實驗呈現的規律不像連續過程。愛因斯坦因此區分兩個問題：波動理論仍可描述平均傳播，但交換事件可能具有粒子式結構。",
                    "若把物質振子與任意頻率的輻射場都直接套用能量均分定理，便得到 Rayleigh–Jeans 型結果，在高頻處導致能量發散。問題不是計算誤差，而是連續能量假設在高頻稀薄輻射極限失效。"
                ], equations: []),
                PaperChapter(id: "l-c2", title: "二、Planck 與 Wien 輻射公式", paragraphs: [
                    "Planck 分布描述溫度 T 下頻率 ν 的黑體能量密度。當 hν 遠大於 kᴮT 時，分母中的 −1 可以忽略，公式退化為 Wien 高頻極限。本文不是先假定光子，而是由此已知的熱輻射分布反推出輻射熵如何依體積改變。",
                    "由熱力學關係 ∂s/∂ρ = 1/T 對能量密度積分，可求出固定能量 E 的單色輻射熵。關鍵結果是熵差只取決於體積比的對數，而且係數正比於 E/(hν)。"
                ], equations: [
                    PaperEquation(id: "l-c2-e1", equation: "ρ(ν,T) ≈ (8πhν³/c³)e^(−hν/kᴮT)", interpretation: "Wien 高頻極限：高頻輻射的能量密度呈指數衰減。"),
                    PaperEquation(id: "l-c2-e2", equation: "S − S₀ = kᴮ(E/hν) ln(V/V₀)", interpretation: "固定能量的單色輻射由 V₀ 壓縮至 V 時的熵變。")
                ]),
                PaperChapter(id: "l-c3", title: "三、由熵推出光量子", paragraphs: [
                    "對含有 N 個互不作用粒子的理想氣體，所有粒子偶然同時落入較小體積 V 的機率為 (V/V₀)ᴺ；Boltzmann 原理又把機率與熵連結。比較氣體與單色輻射的熵式，可辨認出 N = E/(hν)。",
                    "因此，在低密度高頻極限，總能量 E 的輻射在熱力學上如同包含 E/(hν) 個彼此獨立的單元。每一單元攜帶 hν。這是統計類比所支持的啟發性假說，而不是宣稱 Maxwell 方程在所有尺度皆失效。"
                ], equations: [
                    PaperEquation(id: "l-c3-e1", equation: "W = (V/V₀)ᴺ", interpretation: "N 個獨立單元全部進入子體積 V 的機率。"),
                    PaperEquation(id: "l-c3-e2", equation: "E = Nhν", interpretation: "總輻射能量可以視為 N 個能量量子的總和。")
                ]),
                PaperChapter(id: "l-c4", title: "四、三項現象的檢驗", paragraphs: [
                    "Stokes 定律指出，光致發光的放射頻率通常不高於激發光頻率。若每個分子吸收一個 hν 量子，再把部分能量轉為其他形式，這個規律便自然成立；偏離規律時，則需要多量子或其他儲能機制。",
                    "在光電效應中，一個電子取得一個光量子的能量。它先克服材料表面的功函數 φ，剩餘部分成為最大動能。因此提高光強度主要增加電子數，提升頻率才提高單一電子的最大能量，並存在 ν₀ = φ/h 的截止頻率。",
                    "氣體游離也可用同一原則理解：單一量子必須至少具有游離能。於是頻率而非總光強，決定一次微觀事件是否可能發生。"
                ], equations: [
                    PaperEquation(id: "l-c4-e1", equation: "eVₛ = hν − φ", interpretation: "以遏止電位 Vₛ 測量光電子最大動能。"),
                    PaperEquation(id: "l-c4-e2", equation: "ν₀ = φ/h", interpretation: "低於截止頻率時，增加光強仍不能釋出電子。")
                ])
            ],
            conclusion: "光的傳播可由波動理論描述，但在能量交換事件中，光具有不可再分的量子結構。",
            historicalImpact: "這篇論文把量子概念由物質振子推向光本身，奠定光子觀念，並成為愛因斯坦獲頒諾貝爾物理學獎的核心工作。",
            accent: .yellow
        ),
        ScientificPaper(
            id: "brownian-1905",
            number: "PAPER 02",
            icon: "circle.hexagongrid.fill",
            germanTitle: "Über die von der molekularkinetischen Theorie der Wärme geforderte Bewegung von in ruhenden Flüssigkeiten suspendierten Teilchen",
            chineseTitle: "熱的分子運動論所要求的靜止液體中懸浮粒子的運動",
            submitted: "1905 年 5 月 11 日",
            published: "1905 年 7 月 18 日",
            citation: "Annalen der Physik, 17, 549–560",
            doi: "10.1002/andp.19053220806",
            editorialNote: "以下依原論文由滲透壓、遷移率、擴散方程到可觀測位移的順序完整重述，並使用現代的 kᴮ 與擴散係數記號。",
            abstract: "若液體確由持續熱運動的分子組成，尺寸足夠小的懸浮粒子便會承受不平衡碰撞而產生可見的隨機運動。本文結合 van ’t Hoff 滲透壓、Stokes 阻力與 Fick 擴散，導出粒子尺寸、黏度、溫度、擴散係數和均方位移之間的定量關係，使分子運動論與亞佛加厥常數得以由顯微觀察直接檢驗。",
            researchQuestion: "若熱確實源自分子運動，懸浮微粒是否會留下能被顯微鏡測量的統計軌跡？",
            argument: [
                "先由滲透壓與熱力學平衡建立懸浮粒子的濃度分布。",
                "以 Stokes 黏滯阻力描述球形微粒在液體中的遷移率。",
                "比較擴散通量與外力造成的漂移通量，得到擴散係數。",
                "求解一維擴散方程，預言粒子位移分布與均方位移的時間關係。"
            ],
            equations: [
                PaperEquation(id: "b1", equation: "D = kᴮT / (6πηa)", interpretation: "擴散速度由溫度、流體黏度與粒子半徑決定。"),
                PaperEquation(id: "b2", equation: "⟨x²⟩ = 2Dt", interpretation: "單方向均方位移與觀測時間成正比。")
            ],
            chapters: [
                PaperChapter(id: "b-c1", title: "一、懸浮粒子的熱力學", paragraphs: [
                    "考慮稀薄、彼此不作用的球形粒子懸浮於液體。若粒子足夠大，可視為連續介質中的物體；若又足夠小，分子碰撞的瞬時不平衡便不可忽略。平衡時，外力造成的漂移必須由濃度梯度造成的擴散抵銷。",
                    "稀薄懸浮系統的滲透壓服從理想氣體形式。以 n 表示單位體積粒子數，Π = nkᴮT。這一步把不可見的分子熱運動轉換成可測量的巨觀壓力。"
                ], equations: [
                    PaperEquation(id: "b-c1-e1", equation: "Π = nkᴮT", interpretation: "稀薄懸浮粒子的滲透壓。"),
                    PaperEquation(id: "b-c1-e2", equation: "nF = ∂Π/∂x", interpretation: "平衡時外力密度與滲透壓梯度互相抵銷。")
                ]),
                PaperChapter(id: "b-c2", title: "二、阻力、遷移率與擴散係數", paragraphs: [
                    "半徑 a 的球在黏度 η 的液體中以低速運動，Stokes 阻力為 6πηav，因此遷移率 μ，也就是單位外力所造成的速度，等於 1/(6πηa)。",
                    "外力造成的粒子通量為 nμF；濃度梯度造成的擴散通量為 −D∂n/∂x。令平衡總通量為零，再代入滲透壓關係，即得到 Stokes–Einstein 關係。"
                ], equations: [
                    PaperEquation(id: "b-c2-e1", equation: "μ = 1/(6πηa)", interpretation: "球形粒子在黏滯流體中的機械遷移率。"),
                    PaperEquation(id: "b-c2-e2", equation: "D = μkᴮT = kᴮT/(6πηa)", interpretation: "熱擾動與耗散阻力之間的關係。")
                ]),
                PaperChapter(id: "b-c3", title: "三、隨機位移與擴散方程", paragraphs: [
                    "把極短時間 τ 內的粒子位移視為隨機變數，假定不同時間區段的位移獨立，且沒有偏好的方向。對大量粒子的位移分布反覆作卷積，在連續極限得到擴散方程。",
                    "從原點開始的一維粒子，其位置分布為 Gaussian。平均位移為零，不代表粒子不動；真正量度運動尺度的是均方位移。其平方根隨時間的平方根增加，而不是像等速運動般與時間成正比。"
                ], equations: [
                    PaperEquation(id: "b-c3-e1", equation: "∂p/∂t = D ∂²p/∂x²", interpretation: "一維擴散方程。"),
                    PaperEquation(id: "b-c3-e2", equation: "p(x,t) = e^(−x²/4Dt)/√(4πDt)", interpretation: "由原點出發的位移機率密度。"),
                    PaperEquation(id: "b-c3-e3", equation: "xᵣₘₛ = √(2Dt)", interpretation: "可由顯微影像統計的典型位移尺度。")
                ]),
                PaperChapter(id: "b-c4", title: "四、可檢驗預測", paragraphs: [
                    "實驗者只需量測粒子半徑 a、液體黏度 η、絕對溫度 T 與固定時間間隔的位移分布，即可反推出 kᴮ；結合氣體常數 R，便可得到亞佛加厥常數 Nᴬ = R/kᴮ。",
                    "理論也預測清楚的尺度律：溫度越高運動越劇烈；粒子越大或液體越黏，擴散越慢；不同時間間隔測得的均方位移應與 t 成正比。這些不是對單一路徑的預言，而是對大量路徑統計量的預言。"
                ], equations: [
                    PaperEquation(id: "b-c4-e1", equation: "Nᴬ = RT/(6πηaD)", interpretation: "由懸浮粒子的擴散測定亞佛加厥常數。")
                ])
            ],
            conclusion: "只要追蹤大量微粒的位置，就能從可見運動反推出分子熱運動與亞佛加厥常數。",
            historicalImpact: "Jean Perrin 等人的後續實驗驗證了預言，使原子從理論假設成為可定量檢驗的物理實在，也開啟隨機過程的現代研究。",
            accent: .mint
        ),
        ScientificPaper(
            id: "relativity-1905",
            number: "PAPER 03",
            icon: "speedometer",
            germanTitle: "Zur Elektrodynamik bewegter Körper",
            chineseTitle: "論運動物體的電動力學",
            submitted: "1905 年 6 月 30 日",
            published: "1905 年 9 月 26 日",
            citation: "Annalen der Physik, 17, 891–921",
            doi: "10.1002/andp.19053221004",
            editorialNote: "以下依原論文的運動學與電動力學兩大部分重述全部主線；符號改為今日慣用的 γ、c 與向量表示。",
            abstract: "磁鐵與導體的相對運動只產生一種可觀測電流，經典理論卻依哪一方被稱為運動而給出不同解釋。本文以相對性原理和真空光速不變為兩項公設，重新定義同時性，導出 Lorentz 變換、時間膨脹、長度收縮、速度合成、Doppler 效應與電磁場變換，證明 Maxwell 電磁學不需要以太靜止系。",
            researchQuestion: "如何消除 Maxwell 電磁學與 Newton 力學之間的衝突，讓所有慣性觀察者使用同一套物理定律？",
            argument: [
                "以操作方式定義遠隔時鐘同步，指出同時性並非與觀察者無關的絕對概念。",
                "建立相對性原理與光速不變兩項基本公設，不引入以太作為優先靜止系。",
                "由兩公設導出 Lorentz 座標變換，以及時間膨脹和長度收縮。",
                "重新推導速度合成、光行差、Doppler 效應與移動物體的電磁場變換。"
            ],
            equations: [
                PaperEquation(id: "r1", equation: "x′ = γ(x − vt)", interpretation: "運動方向的空間座標依 Lorentz 變換混合時間。"),
                PaperEquation(id: "r2", equation: "t′ = γ(t − vx/c²)", interpretation: "不同慣性系對遠隔事件的同時性判定不同。"),
                PaperEquation(id: "r3", equation: "γ = 1 / √(1 − v²/c²)", interpretation: "相對論效應的尺度由速度與光速之比決定。")
            ],
            chapters: [
                PaperChapter(id: "r-c1", title: "一、同時性的操作定義", paragraphs: [
                    "位於不同地點的時鐘若要比較，必須先定義同步程序。從 A 在 tᴬ 發光，光抵達 B 後立刻反射，並於 t′ᴬ 回到 A；若 B 的反射時刻滿足 tᴮ − tᴬ = t′ᴬ − tᴮ，便定義兩鐘同步。",
                    "這個定義依賴光的傳播規律。兩個事件在某慣性系同時，不保證在相對運動的另一系仍同時，因此時間不能脫離測量程序而被視為宇宙共享的絕對參數。"
                ], equations: [
                    PaperEquation(id: "r-c1-e1", equation: "tᴮ − tᴬ = t′ᴬ − tᴮ", interpretation: "以往返光訊號定義遠隔時鐘同步。")
                ]),
                PaperChapter(id: "r-c2", title: "二、兩項公設與 Lorentz 變換", paragraphs: [
                    "第一，相同形式的物理定律適用於所有慣性參考系；第二，真空光速 c 與光源運動無關。再加上時空均勻、空間各向同性與變換線性，可唯一決定慣性系間的座標關係。",
                    "設 S′ 沿 x 方向以速度 v 相對 S 運動，兩系原點在 t = t′ = 0 重合。要求光錐 x = ±ct 在兩系皆為 x′ = ±ct′，即得到 Lorentz 變換；y、z 不變。"
                ], equations: [
                    PaperEquation(id: "r-c2-e1", equation: "x′ = γ(x − vt)", interpretation: "運動方向的空間座標變換。"),
                    PaperEquation(id: "r-c2-e2", equation: "t′ = γ(t − vx/c²)", interpretation: "時間座標同時依賴舊系的時間與位置。"),
                    PaperEquation(id: "r-c2-e3", equation: "x = γ(x′ + vt′)", interpretation: "把 v 換成 −v 即得反變換，符合相對性。")
                ]),
                PaperChapter(id: "r-c3", title: "三、運動學推論", paragraphs: [
                    "對 S′ 中靜止、固有長度 L₀ 的尺，S 必須在同一 t 測量兩端。變換後得到 L = L₀/γ，故收縮只發生於運動方向。對隨物體同行的時鐘，兩次讀數發生在同一位置 x′，可得 Δt = γΔτ；Δτ 是固有時間。",
                    "速度不能用 Galilean 方式直接相加。若物體在 S′ 的速度為 u′，而 S′ 相對 S 為 v，則沿同方向的合速度為 (u′+v)/(1+u′v/c²)。令 u′ = c，結果仍為 c。"
                ], equations: [
                    PaperEquation(id: "r-c3-e1", equation: "L = L₀/γ", interpretation: "運動方向的長度收縮。"),
                    PaperEquation(id: "r-c3-e2", equation: "Δt = γΔτ", interpretation: "運動時鐘相對座標時間變慢。"),
                    PaperEquation(id: "r-c3-e3", equation: "u = (u′ + v)/(1 + u′v/c²)", interpretation: "共線速度合成律。")
                ]),
                PaperChapter(id: "r-c4", title: "四、光學效應", paragraphs: [
                    "相位在不同慣性系必須描述同一組波面。將平面波的相位代入 Lorentz 變換，可得頻率與傳播方向的變換，從而導出相對論 Doppler 效應與光行差。",
                    "光沿相對運動方向傳來時頻率藍移，背離時紅移；橫向觀察仍存在由時間膨脹造成的橫向 Doppler 效應。這些結果不是額外假設，而是時空變換作用於波四向量的必然後果。"
                ], equations: [
                    PaperEquation(id: "r-c4-e1", equation: "ν′ = γν(1 − (v/c)cosθ)", interpretation: "一般方向的頻率變換。"),
                    PaperEquation(id: "r-c4-e2", equation: "ν′ = ν√((1−β)/(1+β))", interpretation: "光源遠離觀察者時的縱向 Doppler 紅移。")
                ]),
                PaperChapter(id: "r-c5", title: "五、電磁場與帶電粒子", paragraphs: [
                    "要求 Maxwell 方程在 Lorentz 變換下保持形式，電場與磁場必須互相混合。某參考系中的純電場，在運動系通常同時表現為電場和磁場；因此電與磁不是彼此獨立的實體，而是同一電磁場對不同觀察者的分解。",
                    "將場變換套入帶電粒子的運動，可得到高速電子的縱向與橫向響應。原論文仍採當時的電子動力學語言；現代則以四速度與四力統一表達，避免把速度相關係數誤稱為不同種類的質量。"
                ], equations: [
                    PaperEquation(id: "r-c5-e1", equation: "E′∥ = E∥,  B′∥ = B∥", interpretation: "平行於相對速度的場分量不變。"),
                    PaperEquation(id: "r-c5-e2", equation: "E′⊥ = γ(E + v×B)⊥", interpretation: "垂直電場會與磁場混合。"),
                    PaperEquation(id: "r-c5-e3", equation: "B′⊥ = γ(B − v×E/c²)⊥", interpretation: "垂直磁場的對應變換。")
                ])
            ],
            conclusion: "時間與空間測量依賴慣性參考系，但光速與時空規律保持一致；經典力學是 v ≪ c 的近似。",
            historicalImpact: "論文建立狹義相對論的完整運動學與電動力學框架，徹底改寫同時性、時間與空間的物理意義。",
            accent: .blue
        ),
        ScientificPaper(
            id: "mass-energy-1905",
            number: "PAPER 04",
            icon: "function",
            germanTitle: "Ist die Trägheit eines Körpers von seinem Energieinhalt abhängig?",
            chineseTitle: "物體的慣性同它所含的能量有關嗎？",
            submitted: "1905 年 9 月 27 日",
            published: "1905 年 11 月 21 日",
            citation: "Annalen der Physik, 18, 639–641",
            doi: "10.1002/andp.19053231314",
            editorialNote: "以下完整重述原論文的雙光脈衝思想實驗與低速展開，並另列現代四動量形式，避免把後來的表示法誤當成原文直接寫出的公式。",
            abstract: "設一物體在其靜止系向相反方向放出兩束等能量光，使物體仍保持靜止。從相對運動的參考系觀察，兩束光因 Doppler 變換而能量不等。比較放射前後在兩參考系中的能量守恆，發現物體的動能差恰等同於質量減少 L/c² 所造成的差異，因此物體的慣性是其能量內容的量度。",
            researchQuestion: "物體放出或吸收能量後，其慣性質量是否必須發生相應變化？",
            argument: [
                "考慮靜止物體沿相反方向放出兩束總能量為 L 的光，使系統總動量仍為零。",
                "分別在物體靜止系與相對運動參考系計算輻射能量。",
                "利用狹義相對論的光能變換，比較放射前後物體的動能差。",
                "在低速極限辨認動能變化所對應的慣性質量差。"
            ],
            equations: [
                PaperEquation(id: "m1", equation: "Δm = L / c²", interpretation: "物體失去能量 L，其質量減少 L/c²。"),
                PaperEquation(id: "m2", equation: "E₀ = mc²", interpretation: "以現代記號表達，靜止質量本身對應靜止能。")
            ],
            chapters: [
                PaperChapter(id: "m-c1", title: "一、對稱放射的思想實驗", paragraphs: [
                    "令物體在參考系 S 中靜止，初始能量為 E₀。它沿互相相反的方向放出兩個光脈衝，每束能量 L/2。兩束光的總動量互相抵銷，所以放射後物體在 S 中仍靜止，其能量為 E₁。",
                    "在 S 中只需套用能量守恆：物體損失的能量就是兩束光的總能量 L。這一步尚未涉及質量；關鍵來自另一個以速度 v 相對 S 運動的參考系 S′。"
                ], equations: [
                    PaperEquation(id: "m-c1-e1", equation: "E₀ = E₁ + L", interpretation: "物體靜止系中的能量守恆。")
                ]),
                PaperChapter(id: "m-c2", title: "二、在運動參考系計算光能", paragraphs: [
                    "在 S′ 中，物體於放射前後都以速度 −v 運動，但兩束方向相反的光受到不同 Doppler 因子。把兩束光的變換能量相加，角度相關的線性項抵銷，總輻射能量成為 γL。",
                    "設物體在 S′ 中放射前後的總能量分別為 H₀、H₁，能量守恆給出 H₀ = H₁ + γL。將它與靜止系方程相減，便只留下放射前後的動能差。"
                ], equations: [
                    PaperEquation(id: "m-c2-e1", equation: "L′ = γL", interpretation: "兩個反向光脈衝在運動系中的總能量。"),
                    PaperEquation(id: "m-c2-e2", equation: "(H₀−E₀) − (H₁−E₁) = L(γ−1)", interpretation: "括號中的量除去常數後，就是放射前後的動能。")
                ]),
                PaperChapter(id: "m-c3", title: "三、低速極限辨認質量差", paragraphs: [
                    "當 v 遠小於 c，Lorentz 因子展開為 γ − 1 ≈ v²/(2c²)。因此放射前後物體的動能差為 (L/c²)v²/2。另一方面，Newton 低速動能差應為 (Δm)v²/2。逐項比較即得 Δm = L/c²。",
                    "這個論證沒有表示能量只在低速時才有質量；低速展開只是用來把相對論動能差與已知的慣性質量定義連接。結論是：能量 L 離開物體，物體的慣性質量就減少 L/c²。"
                ], equations: [
                    PaperEquation(id: "m-c3-e1", equation: "γ − 1 ≈ v²/(2c²)", interpretation: "Lorentz 因子的低速二階展開。"),
                    PaperEquation(id: "m-c3-e2", equation: "K₀ − K₁ ≈ (L/c²)v²/2", interpretation: "放射造成的動能差。"),
                    PaperEquation(id: "m-c3-e3", equation: "m₀ − m₁ = L/c²", interpretation: "能量損失對應的慣性質量減少。")
                ]),
                PaperChapter(id: "m-c4", title: "四、現代表述與適用範圍", paragraphs: [
                    "若把物體全部靜止能記為 E₀，可寫成 E₀ = mc²。這個熟悉形式是原論文結論的現代凝練寫法；原文直接證明的是能量改變 ΔE 與質量改變 Δm 的關係。",
                    "對具有動量 p 的粒子，完整能量關係為 E² = p²c² + m²c⁴。無質量光子滿足 E = pc；複合系統的質量則包含內部動能、束縛能與場能。質量不是另一種可獨立守恆的物質，而是系統總四動量的不變量。"
                ], equations: [
                    PaperEquation(id: "m-c4-e1", equation: "ΔE = Δmc²", interpretation: "系統能量變化與靜止質量變化的普遍關係。"),
                    PaperEquation(id: "m-c4-e2", equation: "E² = p²c² + m²c⁴", interpretation: "現代相對論的能量—動量不變式。")
                ])
            ],
            conclusion: "物體的質量是其能量內容的度量；能量守恆與質量變化並非兩套獨立帳目。",
            historicalImpact: "這篇三頁短論文提出質量與能量的普遍關係。現代表述由四動量不變量給出更完整的 E² = p²c² + m²c⁴。",
            accent: .orange
        )
    ]
}
