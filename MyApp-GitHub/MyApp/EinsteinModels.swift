import SwiftUI

struct BiographyField: Identifiable {
    let id: String
    let icon: String
    let label: String
    let value: String
}

struct TimelineEvent: Identifiable {
    let id: String
    let year: String
    let title: String
    let description: String
}

enum EinsteinContent {
    static let biography = [
        BiographyField(id: "full-name", icon: "person.text.rectangle", label: "全名", value: "Albert Einstein\n阿爾伯特・愛因斯坦"),
        BiographyField(id: "life", icon: "calendar", label: "生卒", value: "1879 年 3 月 14 日\n1955 年 4 月 18 日（76 歲）"),
        BiographyField(id: "birthplace", icon: "mappin.and.ellipse", label: "出生地", value: "德意志帝國符騰堡王國烏爾姆"),
        BiographyField(id: "death-place", icon: "cross.case", label: "逝世地", value: "美國紐澤西州普林斯頓"),
        BiographyField(id: "citizenship", icon: "globe.europe.africa", label: "公民身分", value: "德國、瑞士與美國；1896–1901 年曾為無國籍者"),
        BiographyField(id: "education", icon: "graduationcap.fill", label: "學歷", value: "蘇黎世聯邦理工學院教師文憑\n蘇黎世大學物理學博士"),
        BiographyField(id: "fields", icon: "atom", label: "研究領域", value: "理論物理、相對論、量子理論、統計力學與宇宙學"),
        BiographyField(id: "institutions", icon: "building.columns.fill", label: "重要機構", value: "瑞士專利局、柏林大學、普魯士科學院、普林斯頓高等研究院"),
        BiographyField(id: "award", icon: "medal.fill", label: "最高榮譽", value: "1921 年諾貝爾物理學獎\n理論物理，尤其光電效應定律"),
        BiographyField(id: "family", icon: "figure.2.and.child.holdinghands", label: "家庭", value: "父母 Hermann 與 Pauline；妹妹 Maja；育有三名子女"),
        BiographyField(id: "residences", icon: "house.and.flag.fill", label: "主要居住地", value: "德國、義大利、瑞士、布拉格、比利時與美國"),
        BiographyField(id: "interests", icon: "music.note", label: "終身興趣", value: "小提琴、室內樂、帆船，以及科學哲學")
    ]

    static let timeline = [
        TimelineEvent(id: "1879", year: "1879", title: "誕生於烏爾姆", description: "出生於德意志帝國的一個世俗猶太家庭。父親經營電氣事業，母親具有良好音樂素養。"),
        TimelineEvent(id: "1884", year: "約 1884", title: "指南針帶來第一次震撼", description: "童年臥病時得到一只指南針；看不見的力量仍能使磁針轉動，成為他探索自然秩序的重要記憶。"),
        TimelineEvent(id: "1895", year: "1895", title: "阿勞的自由教育", description: "首次報考蘇黎世聯邦理工學院未被錄取後，進入瑞士阿勞州立中學，接觸重視理解與想像的教育。"),
        TimelineEvent(id: "1896", year: "1896", title: "進入蘇黎世聯邦理工學院", description: "就讀師範系數理科，學習物理與數學；同年放棄符騰堡國籍，之後數年沒有國籍。"),
        TimelineEvent(id: "1901", year: "1901", title: "取得瑞士國籍", description: "正式成為瑞士公民。畢業後一度難以取得大學職位，以代課與私人教學維生。"),
        TimelineEvent(id: "1902", year: "1902", title: "任職瑞士專利局", description: "在伯恩審查電磁裝置與同步技術，也與朋友組成奧林匹亞學院，討論科學與哲學。"),
        TimelineEvent(id: "1905", year: "1905", title: "奇蹟年與博士學位", description: "完成博士論文，並發表光量子、布朗運動、狹義相對論與質能等價等奠基工作。"),
        TimelineEvent(id: "1909", year: "1909", title: "進入大學學術生涯", description: "離開專利局，出任蘇黎世大學理論物理副教授，之後先後在布拉格與蘇黎世任教。"),
        TimelineEvent(id: "1914", year: "1914", title: "前往柏林", description: "加入普魯士科學院，任職柏林大學與威廉皇家物理研究所，獲得專注研究的條件。"),
        TimelineEvent(id: "1915", year: "1915", title: "完成廣義相對論", description: "經過多年推演，提出描述物質、時空與重力關係的愛因斯坦場方程式。"),
        TimelineEvent(id: "1919", year: "1919", title: "日食觀測使他聞名世界", description: "日食觀測支持太陽重力使星光偏折的預言；相對論迅速從物理學界進入全球大眾文化。"),
        TimelineEvent(id: "1921", year: "1921–22", title: "諾貝爾物理學獎", description: "1921 年度獎項因理論物理、尤其光電效應定律的貢獻授予愛因斯坦，並於翌年頒發。"),
        TimelineEvent(id: "1924", year: "1924–25", title: "玻色–愛因斯坦統計", description: "將玻色的光量子統計推廣至物質粒子，預言後來稱為玻色–愛因斯坦凝聚的量子物態。"),
        TimelineEvent(id: "1933", year: "1933", title: "離開德國，加入高等研究院", description: "納粹掌權後放棄返回德國，成為普林斯頓高等研究院首批教授之一，並協助遭迫害的學者與難民。"),
        TimelineEvent(id: "1939", year: "1939", title: "致羅斯福總統的警告信", description: "在核分裂與納粹威脅的背景下，簽署警告美國政府的信件；他並未直接參與曼哈頓計畫。"),
        TimelineEvent(id: "1940", year: "1940", title: "成為美國公民", description: "取得美國國籍，同時保留瑞士國籍；往後持續投入民權、和平與國際合作議題。"),
        TimelineEvent(id: "1952", year: "1952", title: "婉拒以色列總統職位", description: "以缺乏處理人事與政治職責的經驗為由，婉拒擔任以色列第二任總統。"),
        TimelineEvent(id: "1955", year: "1955", title: "追尋統一場論直到晚年", description: "在普林斯頓因腹主動脈瘤破裂辭世。離世前仍研究統一場論，並參與反核與和平倡議。")
    ]
}
