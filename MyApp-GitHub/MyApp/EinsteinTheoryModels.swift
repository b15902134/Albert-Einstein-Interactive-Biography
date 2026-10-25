import SwiftUI

struct DerivationStep: Identifiable {
    let id: String
    let title: String
    let equation: String
    let explanation: String
}

struct TheoryDetail: Identifiable {
    let id: String
    let number: String
    let icon: String
    let title: String
    let subtitle: String
    let problem: String
    let assumptions: [String]
    let steps: [DerivationStep]
    let result: String
    let symbols: String
    let accent: Color
}

enum EinsteinTheoryContent {
    static let theories = [
        TheoryDetail(
            id: "photoelectric",
            number: "01",
            icon: "sun.max.fill",
            title: "光量子與光電效應",
            subtitle: "光的能量不是連續分配，而是以量子 hν 交換。",
            problem: "經典波動論預期光強越大，電子應取得越多能量；實驗卻顯示電子最大動能由頻率決定，且低於臨界頻率時，再強的光也無法放出電子。",
            assumptions: ["單一光量子的能量為 hν", "一個電子一次吸收一個光量子", "電子逸出金屬至少需克服功函數 φ"],
            steps: [
                DerivationStep(id: "p1", title: "量子能量", equation: "Eγ = hν", explanation: "h 是普朗克常數，ν 是入射光頻率。頻率決定單一光量子的能量。"),
                DerivationStep(id: "p2", title: "能量守恆", equation: "hν = φ + Kₘₐₓ", explanation: "吸收的能量先支付逸出功 φ，剩餘部分成為電子最大動能。"),
                DerivationStep(id: "p3", title: "截止電壓", equation: "eVₛ = hν − φ", explanation: "用反向電壓 Vₛ 恰好阻止最快電子，即可從直線斜率量得 h/e。"),
                DerivationStep(id: "p4", title: "臨界頻率", equation: "ν₀ = φ / h", explanation: "當 Kₘₐₓ = 0，得到最低有效頻率；光強只改變光子數與電流，不改變單電子最大能量。")
            ],
            result: "這套關係同時解釋臨界頻率、幾乎無時間延遲，以及截止電壓對頻率的線性關係。",
            symbols: "h：普朗克常數　ν：頻率　φ：功函數　e：基本電荷　Vₛ：截止電壓",
            accent: .yellow
        ),
        TheoryDetail(
            id: "brownian",
            number: "02",
            icon: "circle.hexagongrid.fill",
            title: "布朗運動",
            subtitle: "把不可見的分子碰撞，轉化為可測量的擴散尺度。",
            problem: "液體中的微粒呈現不規則運動。若這是大量分子熱碰撞造成，就應能從微粒位移反推出分子尺度與亞佛加厥常數。",
            assumptions: ["流體處於熱平衡且均勻", "粒子為半徑 a 的球體並滿足低雷諾數 Stokes 阻力", "長時間尺度下運動可視為擴散"],
            steps: [
                DerivationStep(id: "b1", title: "黏滯阻力", equation: "ζ = 6πηa", explanation: "球形粒子在黏度 η 的流體中緩慢運動，其摩擦係數為 ζ。"),
                DerivationStep(id: "b2", title: "漲落—耗散關係", equation: "D = kᴮT / ζ", explanation: "熱擾動造成擴散，黏滯阻力造成耗散；平衡要求二者由 Einstein 關係連結。"),
                DerivationStep(id: "b3", title: "代入 Stokes 阻力", equation: "D = kᴮT / (6πηa)", explanation: "擴散係數 D 因溫度升高而增加，因粒徑與黏度增加而減小。"),
                DerivationStep(id: "b4", title: "可觀測預言", equation: "⟨x²⟩ = 2Dt", explanation: "單一方向的均方位移與時間成正比；三維情況為 ⟨r²⟩ = 6Dt。")
            ],
            result: "由軌跡量得 D，再利用 kᴮ = R/Nᴬ，便能估算亞佛加厥常數，提供原子實在性的定量證據。",
            symbols: "D：擴散係數　kᴮ：波茲曼常數　T：溫度　η：黏度　a：粒子半徑",
            accent: .mint
        ),
        TheoryDetail(
            id: "special-relativity",
            number: "03",
            icon: "speedometer",
            title: "狹義相對論",
            subtitle: "不變的不是時間與距離，而是光速與時空間隔。",
            problem: "Maxwell 方程預言真空光速為 c，但古典 Galilean 速度相加會讓不同慣性觀察者測得不同光速，兩套理論彼此衝突。",
            assumptions: ["所有慣性參考系中的物理定律形式相同", "真空光速 c 與光源、觀察者的運動無關", "時空均勻、空間各向同性，因此座標變換取線性形式"],
            steps: [
                DerivationStep(id: "s1", title: "保持光錐", equation: "c²t² − x² = c²t′² − x′²", explanation: "對所有慣性觀察者，光都滿足 x = ±ct；因此座標變換必須保持時空間隔。"),
                DerivationStep(id: "s2", title: "Lorentz 因子", equation: "γ = 1 / √(1 − v²/c²)", explanation: "要求變換可逆、在 v ≪ c 時回到 Galilean 極限，可決定尺度因子 γ。"),
                DerivationStep(id: "s3", title: "座標變換", equation: "x′ = γ(x − vt)\nt′ = γ(t − vx/c²)", explanation: "空間與時間不再各自獨立；不同地點事件的時間座標會因相對運動而混合。"),
                DerivationStep(id: "s4", title: "時間膨脹", equation: "Δt = γΔτ", explanation: "若兩事件在移動時鐘的位置相同，Δτ 是固有時間；其他觀察者測得更長的時間間隔。")
            ],
            result: "同時性的相對性、時間膨脹與長度收縮不是光傳播延遲造成的假象，而是 Lorentz 幾何的直接結果。",
            symbols: "c：真空光速　v：參考系相對速度　γ：Lorentz 因子　Δτ：固有時間",
            accent: .blue
        ),
        TheoryDetail(
            id: "mass-energy",
            number: "04",
            icon: "function",
            title: "質能等價",
            subtitle: "靜止質量是系統總能量的一種形式。",
            problem: "在 Lorentz 對稱下，能量與動量必須形成一致的相對論量；經典動能 ½mv² 只能是低速近似。",
            assumptions: ["使用狹義相對論的 Lorentz 對稱", "封閉系統的四動量守恆", "m 表示與觀察者無關的靜止質量"],
            steps: [
                DerivationStep(id: "m1", title: "相對論動量與能量", equation: "p = γmv　　E = γmc²", explanation: "能量與三維動量是四動量的分量，會在 Lorentz 變換下彼此混合。"),
                DerivationStep(id: "m2", title: "不變關係", equation: "E² − p²c² = m²c⁴", explanation: "四動量的 Minkowski 長度在所有慣性系中相同。"),
                DerivationStep(id: "m3", title: "靜止系", equation: "p = 0  ⇒  E₀ = mc²", explanation: "在物體靜止參考系，總能量仍不為零；這就是靜止能。"),
                DerivationStep(id: "m4", title: "回到經典極限", equation: "E ≈ mc² + ½mv² + …", explanation: "展開 γ 後，第一項是靜止能，第二項正是低速經典動能。")
            ],
            result: "現代寫法固定使用靜止質量 m；物體加速時增加的是總能量與動量，而不是把質量描述成隨速度增加。",
            symbols: "E：總能量　E₀：靜止能　p：相對論動量　m：靜止質量",
            accent: .orange
        ),
        TheoryDetail(
            id: "general-relativity",
            number: "05",
            icon: "globe.americas.fill",
            title: "廣義相對論",
            subtitle: "重力不是普通作用力，而是物質與能量塑造的時空幾何。",
            problem: "Newton 重力假設瞬時作用，與相對論的有限傳播速度不相容；狹義相對論也只直接處理無重力的慣性參考系。",
            assumptions: ["局部自由落體系中，非重力物理退化為狹義相對論", "物理定律可用一般座標協變形式表達", "場方程只含度規至二階導數，並滿足局部能量動量守恆"],
            steps: [
                DerivationStep(id: "g1", title: "時空度規", equation: "ds² = gμν dxμ dxν", explanation: "度規 gμν 定義時鐘讀值、距離與光錐，是描述重力場的基本變數。"),
                DerivationStep(id: "g2", title: "自由落體", equation: "d²xμ/dτ² + Γμᵅᵝ(dxᵅ/dτ)(dxᵝ/dτ) = 0", explanation: "不受非重力作用的物體沿測地線運動；Christoffel 符號由度規的一階導數構成。"),
                DerivationStep(id: "g3", title: "幾何與物質耦合", equation: "Gμν + Λgμν = (8πG/c⁴)Tμν", explanation: "左側 Einstein 張量描述曲率，右側應力—能量張量包含能量、動量與壓力。"),
                DerivationStep(id: "g4", title: "弱場極限", equation: "g₀₀ ≈ −(1 + 2Φ/c²)  ⇒  ∇²Φ = 4πGρ", explanation: "當場很弱且物質速度遠低於光速，場方程回到 Newton 的 Poisson 方程。")
            ],
            result: "水星近日點進動、光線偏折、重力紅移、黑洞與膨脹宇宙，都由同一套幾何框架描述。",
            symbols: "gμν：度規　Gμν：Einstein 張量　Tμν：應力—能量張量　Λ：宇宙常數",
            accent: .indigo
        ),
        TheoryDetail(
            id: "bose-einstein",
            number: "06",
            icon: "atom",
            title: "玻色–愛因斯坦統計",
            subtitle: "不可分辨的整數自旋粒子，可以大量佔據同一量子態。",
            problem: "若把相同粒子視為可分辨，便無法正確計數光子與某些物質粒子的量子態；必須改變統計方式。",
            assumptions: ["粒子不可分辨且遵守 Bose 統計", "理想氣體近似，粒子間交互作用可忽略", "粒子數固定時化學勢 μ 不超過基態能量"],
            steps: [
                DerivationStep(id: "be1", title: "平均佔據數", equation: "n̄(ε) = 1 / {exp[(ε−μ)/(kᴮT)] − 1}", explanation: "分母的負一號允許任意多個玻色子佔據同一狀態。"),
                DerivationStep(id: "be2", title: "熱德布羅意波長", equation: "λᵀ = h / √(2πmkᴮT)", explanation: "降溫使物質波長增長；當波包彼此重疊，量子統計成為主導。"),
                DerivationStep(id: "be3", title: "激發態容量", equation: "Nₑₓ = (V/λᵀ³) ζ(3/2)", explanation: "三維理想氣體在 μ → 0 時，激發態能容納的粒子數存在上限。"),
                DerivationStep(id: "be4", title: "臨界溫度與凝聚比例", equation: "T꜀ = [2πℏ²/(mkᴮ)] [n/ζ(3/2)]²ᐟ³\nN₀/N = 1 − (T/T꜀)³ᐟ²", explanation: "低於 T꜀，超出激發態容量的粒子宏觀佔據基態。")
            ],
            result: "凝聚不是粒子在空間中普通堆積，而是大量粒子共享同一量子基態，呈現宏觀量子行為。",
            symbols: "μ：化學勢　λᵀ：熱波長　n=N/V：數密度　ζ：Riemann zeta 函數",
            accent: .cyan
        ),
        TheoryDetail(
            id: "gravitational-waves",
            number: "07",
            icon: "waveform.path.ecg",
            title: "重力波",
            subtitle: "弱小的時空擾動，以光速把天體劇變的信息帶到遠方。",
            problem: "若重力場會隨物質運動改變，且影響不能超光速傳播，Einstein 場方程應允許波動解。",
            assumptions: ["遠離波源且重力場很弱", "將度規寫成平直時空加上小擾動 |hμν| ≪ 1", "保留 h 的一階項，忽略非線性高階項"],
            steps: [
                DerivationStep(id: "w1", title: "弱場展開", equation: "gμν = ημν + hμν", explanation: "ημν 是平直 Minkowski 度規，hμν 是微小的時空擾動。"),
                DerivationStep(id: "w2", title: "線性化場方程", equation: "□h̄μν = −(16πG/c⁴)Tμν", explanation: "在 Lorenz 規範下，非線性場方程化為帶源波動方程。"),
                DerivationStep(id: "w3", title: "真空傳播", equation: "Tμν = 0  ⇒  □h̄μν = 0", explanation: "波動算符的解以 c 傳播，並具有 plus 與 cross 兩種張量偏振。"),
                DerivationStep(id: "w4", title: "四極輻射", equation: "hᵢⱼᵀᵀ = (2G/c⁴r) d²Qᵢⱼᵀᵀ/dt²", explanation: "遠場振幅與質量四極矩的二階時間導數成正比，並隨距離 r 衰減。")
            ],
            result: "干涉儀測量無因次應變 h ≈ ΔL/L。雙黑洞合併造成的極小長度變化，成為直接觀測時空動力學的新窗口。",
            symbols: "ημν：平直度規　hμν：度規擾動　□：波動算符　Qᵢⱼ：質量四極矩",
            accent: .purple
        )
    ]
}
