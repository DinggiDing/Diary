//
//  EditView2.swift
//  Diary
//
//  Created by 성재 on 3/8/24.
//

import SwiftUI
import ExyteMediaPicker
import TipKit
import NavigationBarLargeTitleItems
import SwiftUIIntrospect

struct EditView2: View {
//    // MARK: Core data variables
//   @EnvironmentObject var manager: DataManager
//   @Environment(\.managedObjectContext) var viewContext
    
    @Binding var isPresented: Bool
    @Binding var isHiding: Bool
    var isThirdTab: Bool = false
   
    
    // MARK: Core data에 넣을 것
    @State private var title: String = ""
    @State private var maintext: String = ""
    @State private var date: Date = Date()
    @State private var maintext_fontsize : Int = 16
    @State private var maintext_alignment : TextAlignment = .leading
    @State private var maintext_linespacing : Int = 10
    @State private var image_ratio: Float = 0.8
    @State private var image_height: Int = 150
    
    
    @State private var ispresented_imgpicker: Bool = false
    @State private var medias: [Media] = []
    @State private var alignment_imagename : String = "text.alignleft"
            
    let columns = [GridItem(.flexible(), spacing: 1)]
    
    @State private var popups: Bool = false
    @State private var ispopups: Int = 0
    @State private var ispopups2: Int = 0
    @State private var donedone: Bool = false
    
    @State private var url : [URL] = []
    
    private let tip = FavoriteBackyardTip()
    
    
    init(isPresented: Binding<Bool>, isHiding: Binding<Bool>, isThirdTab: Bool) {
        _isPresented = isPresented
        _isHiding = isHiding
        self.isThirdTab = isThirdTab
        
        UIToolbar.appearance().barTintColor = .black
        UIToolbar.appearance().layer.shadowColor = UIColor.black.cgColor
        UIToolbar.appearance().layer.shadowOpacity = 0.1
        UIToolbar.appearance().layer.shadowOffset = CGSize(width: 0, height: 2)
        UIToolbar.appearance().layer.shadowRadius = 10.0
        
    }
    
 
    var body: some View {
        NavigationView {
            
            VStack {
                ZStack {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .center, spacing: 24) {
                                HStack(spacing: 18) {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundColor(Color("gray6"))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 5, height: 5)
                                    HStack {
                                        HStack(spacing: 5) {
                                            Text(Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                                .font(.SUIT_Regular)
                                                .foregroundStyle(Color("gray3"))
                                                .popoverTip(tip)
                                            
                                            if ispopups != 0 {
                                                Image(systemName: Mockdata.iconImageNames[ispopups-1])
                                            }
                                            
                                            if ispopups2 != 0 {
                                                Text(Mockdata2.iconImageNames[ispopups2-1])
                                            }
                                        }
                                        
                                    }
                                    Spacer()
                                }.padding(.bottom, 12)
                                    .padding(.top, 42)
                                    .onTapGesture {
                                        popups.toggle()
                                    }
                                
                                HStack {
                                    Spacer()
                                    
                                    TextField(formatDate(Date.now), text: $title, axis: .vertical)
                                        .font(.Arita_buriBold_edt)
                                        .frame(width: 280, alignment: .leading)
                                        .accentColor(.gray)
                                        .id("textda")
                                    
                                    /// maxLength 설정
                                        .onChange(of: title) { _ in
                                            proxy.scrollTo("textda", anchor: .bottom)
                                            title = String(title.prefix(20))
                                        }
                                    
                                    Spacer()
                                }
                                
                                //                            Spacer().frame(height:35)
                                
                                if !medias.isEmpty {
                                    ScrollView(.horizontal) {
                                        LazyHGrid(rows: columns, spacing: 10) {
                                            ForEach(medias) { media in
                                                MediaCell(viewModel: MediaCellViewModel(media: media), url_array: $url)
                                                    .aspectRatio(CGFloat(image_ratio), contentMode: .fill)
                                            }
                                        }
                                    }.frame(height: CGFloat(image_height))
                                        .padding(.leading, AppConfig.homeWidth*0.1)
                                        .onTapGesture {
                                            if image_ratio == 0.8 {
                                                image_ratio = 1.0
                                                image_height = 200
                                            } else {
                                                image_ratio = 0.8
                                                image_height = 150
                                            }
                                        }
                                }
                                
                                
                                HStack {
                                    Spacer()
                                    ZStack {
                                        TextEditor(text: $maintext)
                                            .contentShape(Rectangle())
                                            .font(.custom("Arita-buri-Medium_OTF", size: CGFloat(maintext_fontsize)))
                                            .frame(width: 280, alignment: .leading)
                                            .multilineTextAlignment(maintext_alignment)
                                            .frame(minHeight: 150)
                                            .lineSpacing(CGFloat(maintext_linespacing))
                                            .accentColor(.black)
                                            .id("texteditorda")
                                        
                                        /// typing focus scroll
                                            .onChange(of: maintext) { _ in
                                                proxy.scrollTo("texteditorda", anchor: .bottom)
                                            }
        
                                        if maintext.isEmpty {
                                            VStack {
                                                Text(formatDate(Date.now))
                                                    .font(.Arita_buriMedium)
                                                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                                    .foregroundStyle(Color.gray.opacity(0.55))
                                                    .frame(width: 280, alignment: .leading)
                                                    .padding(.top, 10)
                                                    .padding(.leading, 6)
                                                Spacer()
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                
                                Spacer()
                                
                            }.frame(width: AppConfig.homeWidth-52)
                                .padding(.bottom, 44)
                        }
                    }
                    
                        
                    
                    HStack {
                        Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                            .foregroundStyle(.gray5)
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            publishButton(title: $title, status: $maintext, image: $url, donedone: $isPresented)
                            Spacer()
                        }
                    }.padding(.bottom, 6)
                        .ignoresSafeArea(.keyboard)
                    
                    
                }
                .sheet(isPresented: $ispresented_imgpicker, content: {
                    CustomizedMediaPicker(
                        isPresented: $ispresented_imgpicker,
                        medias: $medias
                    )
                })
                .sheet(isPresented: $popups, content: {
                    PopupBottomFirst(isPresented: $popups, ispreint: $ispopups, ispreint2: $ispopups2)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(40)
                    
                })
                
            }
            .onAppear {
                isHiding = true
            }
            .toolbar {
                if !isThirdTab {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Cancel") {
                            isPresented = false
                        }.foregroundStyle(.black)
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Button(action: {
//                            self.saveTodo(title: title, date: Date.now, status: status.rawValue)
                            // Call a function to handle saving or further processing of the newTodo
                            // For example, you can pass it to a delegate or callback.
                        }, label: {
                            Image(systemName: "circle.righthalf.filled")
                                .foregroundStyle(.gray5)
                        })
                        Button(action: {
                            if maintext_fontsize == 18 {
                                maintext_fontsize = 14
                            } else {
                                maintext_fontsize = maintext_fontsize + 2
                            }
                        }, label: {
                            Image(systemName: "textformat.size")
                                .foregroundStyle(.gray5)
                        })
                        Button(action: {
                            switch maintext_alignment {
                            case .leading:
                                maintext_alignment =  .center
                                alignment_imagename = "text.aligncenter"
                            case .center:
                                maintext_alignment = .trailing
                                alignment_imagename = "text.alignright"
                            case .trailing:
                                maintext_alignment = .leading
                                alignment_imagename = "text.alignleft"
                                
                            default:
                                maintext_alignment = .leading
                                alignment_imagename = "text.alignleft"
                            }
                        }, label: {
                            Image(systemName: alignment_imagename)
                                .foregroundStyle(.gray5)
                        })
                        Button(action: {
                            if maintext_linespacing == 12 {
                                maintext_linespacing = 8
                            } else {
                                maintext_linespacing = maintext_linespacing + 2
                                
                            }
                        }, label: {
                            Image(systemName: "arrow.up.and.down.text.horizontal")
                                .foregroundStyle(.gray5)
                        })
                        Button(action: {
                            ispresented_imgpicker.toggle()
                        }, label: {
                            Image(systemName: "photo")
                                .foregroundStyle(.gray5)
                        })
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Button(action: {
                            endTextEditing()
                        }, label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .foregroundStyle(.gray5)
                        })

                    }
                }
            }
            
        }
        .ignoresSafeArea()

        .navigationBarHidden(true)
    }

    
        
    
    
//    // MARK: Core Data Operations
//    func saveTodo(title: String, date: Date, status: String) {
//        let todo = DB_core(context: self.viewContext)
//        todo.id = UUID()
//        todo.title = title
//        todo.date = date
//        todo.status = status
//        
//        do {
//            try self.viewContext.save()
//            print("Todo saved!")
//        } catch {
//            print("whoops \(error.localizedDescription)")
//        }
//    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 일기"
        return formatter.string(from: date)
    }
    
    private func formatDate2(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

//#Preview {
//    EditView2()
//}
