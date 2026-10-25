import MapKit
import SwiftUI

struct EinsteinPlace: Identifiable {
    let id: String
    let name: String
    let period: String
    let significance: String
    let coordinate: CLLocationCoordinate2D
}

enum EinsteinPlaces {
    static let all = [
        EinsteinPlace(
            id: "ulm",
            name: "烏爾姆",
            period: "1879",
            significance: "出生地",
            coordinate: CLLocationCoordinate2D(latitude: 48.4011, longitude: 9.9876)
        ),
        EinsteinPlace(
            id: "zurich",
            name: "蘇黎世",
            period: "1896—1914",
            significance: "求學、博士研究與任教",
            coordinate: CLLocationCoordinate2D(latitude: 47.3769, longitude: 8.5417)
        ),
        EinsteinPlace(
            id: "bern",
            name: "伯恩",
            period: "1902—1909",
            significance: "專利局與 1905 奇蹟年",
            coordinate: CLLocationCoordinate2D(latitude: 46.9480, longitude: 7.4474)
        ),
        EinsteinPlace(
            id: "berlin",
            name: "柏林",
            period: "1914—1933",
            significance: "廣義相對論與學術高峰",
            coordinate: CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050)
        ),
        EinsteinPlace(
            id: "princeton",
            name: "普林斯頓",
            period: "1933—1955",
            significance: "流亡、統一場論與晚年",
            coordinate: CLLocationCoordinate2D(latitude: 40.3573, longitude: -74.6672)
        )
    ]
}

struct EinsteinMapSection: View {
    private let places = EinsteinPlaces.all
    @State private var selectedPlaceID = "bern"
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 46.9480, longitude: 7.4474),
            span: MKCoordinateSpan(latitudeDelta: 4.5, longitudeDelta: 4.5)
        )
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            SectionHeader(
                eyebrow: "A life across continents",
                title: "愛因斯坦的世界座標",
                subtitle: "拖曳與縮放地圖，或點選城市卡片，探索塑造其人生與科學工作的五座城市。"
            )

            Picker("選擇城市", selection: $selectedPlaceID) {
                ForEach(places.enumerated(), id: \.element.id) { index, place in
                    Text("\(index + 1)")
                        .tag(place.id)
                        .accessibilityLabel(place.name)
                }
            }
            .pickerStyle(.segmented)

            Map(position: $cameraPosition) {
                if let selectedPlace {
                    Annotation(selectedPlace.name, coordinate: selectedPlace.coordinate, anchor: .bottom) {
                        EinsteinMapPin(number: selectedNumber, place: selectedPlace)
                    }
                }
            }
            .mapStyle(.standard(elevation: .realistic, pointsOfInterest: .excludingAll))
            .mapControls {
                MapCompass()
                MapScaleView()
            }
            .frame(height: 360)
            .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(Color.einsteinGold.opacity(0.24), lineWidth: 1)
            }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 145), alignment: .leading)], spacing: 12) {
                ForEach(places.enumerated(), id: \.element.id) { index, place in
                    Button {
                        selectedPlaceID = place.id
                    } label: {
                        EinsteinMapLegendRow(
                            number: index + 1,
                            place: place,
                            isSelected: selectedPlaceID == place.id
                        )
                    }
                    .buttonStyle(.einsteinCard)
                    .accessibilityHint("在地圖上顯示這座城市")
                }
            }
        }
        .onChange(of: selectedPlaceID) {
            guard let selectedPlace else { return }

            withAnimation(.smooth(duration: 0.65)) {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: selectedPlace.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 4.5, longitudeDelta: 4.5)
                    )
                )
            }
        }
    }

    private var selectedPlace: EinsteinPlace? {
        places.first { $0.id == selectedPlaceID }
    }

    private var selectedNumber: Int {
        guard let index = places.firstIndex(where: { $0.id == selectedPlaceID }) else { return 1 }
        return index + 1
    }
}

struct EinsteinMapPin: View {
    let number: Int
    let place: EinsteinPlace

    var body: some View {
        Text("\(number)")
            .font(.einsteinCaption.bold().monospacedDigit())
            .foregroundStyle(Color.einsteinNavy)
            .frame(width: 30, height: 30)
            .background(Color.einsteinGold, in: Circle())
            .overlay { Circle().stroke(.white, lineWidth: 2) }
            .shadow(color: .black.opacity(0.22), radius: 4, y: 2)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(place.name)，\(place.period)，\(place.significance)")
    }
}

struct EinsteinMapLegendRow: View {
    let number: Int
    let place: EinsteinPlace
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            Text("\(number)")
                .font(.einsteinCaption2.bold().monospacedDigit())
                .foregroundStyle(Color.einsteinNavy)
                .frame(width: 22, height: 22)
                .background(Color.einsteinGold, in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("\(place.name) · \(place.period)")
                    .font(.einsteinCaption.bold())
                    .foregroundStyle(.primary)
                Text(place.significance)
                    .font(.einsteinCaption2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 54, alignment: .topLeading)
        .padding(10)
        .background(
            Color.einsteinGold.opacity(isSelected ? 0.15 : 0.04),
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.einsteinGold.opacity(isSelected ? 0.55 : 0.12), lineWidth: 1)
        }
        .contentShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .animation(.smooth(duration: 0.25), value: isSelected)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
