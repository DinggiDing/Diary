//
//  ListView.swift
//  Diary
//
//  Created by 성재 on 2/29/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 18) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(Color("gray6"))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 5, height: 5)
                Text(Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                    .font(.SUIT_Regular)
                    .foregroundStyle(Color("gray3"))
            }.padding(.bottom, 12)
            
            HStack {
                Spacer()
                Text("잊지 못할 하루,\n나만의 소중한 기억으로 남긴다")
                    .font(.Arita_buriBold)
                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 280, alignment: .leading)
                    
                Spacer()
            }
            
            HStack {
                Spacer()
                Image("sampleimg")
                    .resizable()
                    .frame(width: AppConfig.homeLatestCarouselImageWidth, height: AppConfig.homeLatestCarouselImageHeight)
                    .aspectRatio(contentMode: .fit)
            }.padding(.trailing, 24)
            
            HStack {
                Spacer()
                Text("별빛 로운 미쁘다 산들림 로운 옅구름 아리아 노트북 나비잠 이플 비나리 곰다시 포도 여우비 감사합니다 감또개 바람꽃 도담도담 비나리 아름드리 비나리 우리는 달볓 감또개 사과 아리아 감사합니다\n\n늘품 노트북 별빛 여우비 바나나 나래 예그리나 별하 미리내 포도 가온누리 그루잠 다솜 다솜 포도 컴퓨터 포도 아름드리 도서관 그루잠 아름드리 아름드리 이플.")
                    .font(.custom("Arita-buri-Medium_OTF", size: 14))
                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 280, alignment: .leading)
                Spacer()
            }

            
        }.frame(width: AppConfig.homeWidth-52)
            .padding(.bottom, 60)
    }
}

#Preview {
    ListView()
}
