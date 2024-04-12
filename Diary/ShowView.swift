//
//  ShowView.swift
//  Diary
//
//  Created by 성재 on 3/24/24.
//

import SwiftUI
import Kingfisher

struct ShowView: View {
    
    let columns = [GridItem(.flexible(), spacing: 1)]
    @State private var image_ratio: Float = 0.8
    @State private var image_height: Int = 150
    
//    @Binding var isPresented: Bool
//    @Binding var title: String
//    @Binding var maintext: String
//    @Binding var date: Date
    var db: DB_core
    
    @Binding var isHiding: Bool
    
    init(db: DB_core, isHiding: Binding<Bool>) {
        self.db = db
        self._isHiding = isHiding
    }

    
    var body: some View {
        VStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        //                        ScrollView {
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
                                    
                                }
                            }
                            
                            
                            Spacer()
                        }.padding(.bottom, 12)
                        
                        HStack {
                            Spacer()
                            
                            Text(db.title ?? "")
                                .font(.Arita_buriBold_edt)
                                .frame(width: 280, alignment: .leading)
                                .accentColor(.gray)
                            
                            Spacer()
                        }
                        
                        //                            Spacer().frame(height:35)
                        
                        if !db.image.isEmpty {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: columns, spacing: 10) {
                                    ForEach(db.image, id: \.self) { images in
                                        
                                        KFImage.url(images)
                                            .resizable()
                                            .aspectRatio(CGFloat(image_ratio), contentMode: .fill)
                                            .clipped()
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
                                Text(db.status ?? "")
                                    .contentShape(Rectangle())
                                    .font(.Arita_buriMedium)
                                    .id("Texteditor")
                                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                    .accentColor(.black)
                                    .frame(minHeight: 40)
                                    .frame(width: 280, alignment: .leading)

                                
                            }
                            Spacer()
                        }
                        Spacer()
                    }.frame(width: AppConfig.homeWidth-52)
                    
                        .padding(.bottom, 44)
                    
                }
                    
                
                HStack {
                    Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                        .foregroundStyle(.gray5)
                    Spacer()
                }
                
            }
            

            
        }
        .onAppear {
            isHiding = true
        }
    }
}
//
//#Preview {
//    ShowView()
//}
