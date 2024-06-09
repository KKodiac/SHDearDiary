import ComposableArchitecture
import SwiftUICalendar
import SwiftUI
import Shared

struct DiaryView: View {
    private let upperSpacerHeight: CGFloat = 0.45
    @StateObject private var controller = CalendarController()
    @Bindable var store: StoreOf<DiaryCore>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            GeometryReader { reader in
                ZStack {
                    VStack {
                        HStack {
                            Text("Dear Diary").primaryTextStyle()
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "gear")
                                    .font(.title)
                                    .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
                                    .foregroundStyle(UserInterfaceAsset.ddAccent.swiftUIColor)
                            }
                            
                        }.padding([.horizontal, .top], 20)
                        HStack(alignment: .center, spacing: 0) {
                            Button {
                                controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
                            } label: {
                                Image("arrowleft")
                            }
                            .padding(25)
                            Text("\(String(controller.yearMonth.year)).\(controller.yearMonth.month)")
                                .font(.system(size: 20))
                                .bold()
                                .padding(.vertical)
                            Button {
                                controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
                            } label: {
                                Image("arrowright")
                            }
                            .padding(25)
                        }
                        CalendarView(controller, header: { week in
                            GeometryReader { geometry in
                                Text("\(week.shortString.first?.uppercased() ?? "")")
                                    .font(.subheadline)
                                    .bold()
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height,
                                           alignment: .center)
                            }
                        }, component: { date in
                            GeometryReader { geometry in
                                Text("\(date.day)")
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .font(.caption)
                                    .fontWeight(store.focusDate == date ? .bold : .light)
                                    .background(UserInterfaceAsset.ddAccent.swiftUIColor.clipShape(Circle())
                                        .opacity(store.focusDate == date ? 1 : 0)
                                    )
                                    .foregroundStyle(store.focusDate == date ? Color.white : Color.black)
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                
                                    .onTapGesture {
                                        store.send(.calendarDateTapped(date))
                                    }
                            }
                        })
                        .padding([.horizontal, .bottom], 30)
                        Spacer(minLength: reader.size.height * upperSpacerHeight)
                    }
                    VStack {
                        Spacer(minLength: reader.size.height * (1.0 - upperSpacerHeight))
                        Divider()
                            .overlay {
                                HStack {
                                    Text("\(store.focusDate.date?.formatted(date: .abbreviated, time: .omitted) ?? "")")
                                        .foregroundStyle(Color.gray)
                                        .padding(.trailing)
                                        .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
                                    Spacer()
                                }
                                
                            }
                            .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
                            .padding()
                        
                        ScrollView {
                            LazyVStack {
                                ForEach(store.focusedEntries, id: \.self) { entry in
                                    Button {
                                        store.send(.diaryCardTapped(entry))
                                    } label: {
                                        Card(title: entry.title, content: entry.content, timestamp: entry.createdAt)
                                    }
                                    .tint(.black)
                                }
                            }
                        }
                        
                    }
                    .frame(minHeight: reader.size.height * 0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .ignoresSafeArea(.all, edges: .bottom)
                }
                
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            store.send(.memoirTapped)
                        } label: {
                            UserInterfaceAsset.imoji.swiftUIImage
                                .padding(15)
                        }
                        .background(UserInterfaceAsset.ddAccent.swiftUIColor)
                        .clipShape(Circle())
                    }
                }
                .padding()
            }
            .background(UserInterfaceAsset.ddPrimaryBackground.swiftUIColor)
        } destination: { store in
            switch store.state {
            case .log:
                if let store = store.scope(state: \.log, action: \.log) {
                    MemoirView(store: store)
                }
            case .detail:
                if let store = store.scope(state: \.detail, action: \.detail) {
                    DiaryDetailView(store: store)
                }
            case .settings:
                EmptyView()
            }
        }
    }
}
