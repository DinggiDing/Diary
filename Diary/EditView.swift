//
//  EditView.swift
//  Diary
//
//  Created by 성재 on 3/2/24.
//

import SwiftUI
import ExyteMediaPicker

struct EditView: View {

    // MARK: Core data variables
   @EnvironmentObject var manager: DataManager
   @Environment(\.managedObjectContext) var viewContext
   
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var maintext: String = ""
    @State private var date: Date = Date()
//    @State private var status: TodoStatus = .pending
    
    @State private var ispresented_imgpicker: Bool = false
    @State private var medias: [Media] = []
    
            
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 24) {
                    ScrollView {
                        HStack(spacing: 18) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .foregroundColor(Color("gray6"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 5, height: 5)
                            Text(Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                .font(.SUIT_Regular)
                                .foregroundStyle(Color("gray3"))
                            Spacer()
                        }.padding(.bottom, 12)
                        
                        HStack {
                            Spacer()

                            TextField(formatDate(Date.now), text: $title, axis: .vertical)
                                .font(.Arita_buriBold_edt)
                                .frame(width: 280, alignment: .leading)
                                    
                            /// maxLength 설정
                                .onChange(of: title) { _ in
                                    title = String(title.prefix(20))
                                }
                                
                            Spacer()
                        }
                        
//                        HStack {
//                            Spacer()
//                            Image("sampleimg")
//                                .resizable()
//                                .frame(width: AppConfig.homeLatestCarouselImageWidth, height: AppConfig.homeLatestCarouselImageHeight)
//                                .aspectRatio(contentMode: .fit)
//                        }.padding(.trailing, 24)
                                  
                        HStack {
                            Spacer()
                            ZStack {
                                TextEditor(text: $maintext)
                                    .font(.custom("Arita-buri-Medium_OTF", size: 14))
                                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                    .frame(minHeight: 40)
                                    .frame(width: AppConfig.homeWidth2, alignment: .leading)
                                    
                                
                                if maintext.isEmpty {
                                    Text(formatDate(Date.now))
                                        .font(.custom("Arita-buri-Medium_OTF", size: 14))
                                        .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(Color.gray.opacity(0.55))
                                        .frame(width: 280, alignment: .leading)
                                        .padding(.top, 10)
                                        .padding(.leading, 6)
                                }
                            }
                            Spacer()
                        }
                        
                        if !medias.isEmpty {
                            Section {
//                                LazyVGrid(columns: columns, spacing: 1) {
                                    ForEach(medias) { media in
//                                        MediaCell(viewModel: MediaCellViewModel(media: media), url_array: url)
//                                            .aspectRatio(1, contentMode: .fill)

                                    }
//                                }
                            }
                        }
                        

                    }
                }.frame(width: AppConfig.homeWidth-52)
                    .padding(.bottom, 60)

                    .toolbar {
                        //                ToolbarItem(placement: .navigationBarLeading) {
                        //                    Button("Cancel") {
                        //                        isPresented = false
                        //                    }
                        //                }
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Button(action: {
//                                    self.saveTodo(title: title, date: Date.now, status: status.rawValue)
                                    
                                    // Call a function to handle saving or further processing of the newTodo
                                    // For example, you can pass it to a delegate or callback.
                                    isPresented = false
                                }, label: {
                                    Image(systemName: "circle.righthalf.filled")
                                        .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                })
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "textformat.size")
                                        .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                })
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "text.alignleft")
                                        .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                })
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "arrow.up.and.down.text.horizontal")
                                        .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                })
                                Button(action: {
                                    ispresented_imgpicker.toggle()
                                }, label: {
                                    Image(systemName: "photo")
                                        .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                })
                                Button(action: {
                                    endTextEditing()
                                }, label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                        .foregroundStyle(Color(red: 0, green: 0, blue: 0))
                                })
                                
                            }
                            .border(Color.black)
                        }
                    }
                    
                HStack {
                    Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                        .foregroundStyle(.gray5)
                    Spacer()
                }
                
               
                
            }.sheet(isPresented: $ispresented_imgpicker, content: {
                CustomizedMediaPicker(
                    isPresented: $ispresented_imgpicker,
                    medias: $medias
                )
            })

        }
        
    }
    
    // MARK: Core Data Operations
    func saveTodo(title: String, date: Date, status: String) {
        let todo = DB_core(context: self.viewContext)
        todo.id = UUID()
        todo.title = title
        todo.date = date
        todo.status = status
        
        do {
            try self.viewContext.save()
            print("Todo saved!")
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 일기"
        return formatter.string(from: date)
    }
}

#Preview {
    EditView(isPresented: .constant(true))
}


extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}

