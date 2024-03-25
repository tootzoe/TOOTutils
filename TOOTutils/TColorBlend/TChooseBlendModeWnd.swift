//
//  TChooseBlendModeWnd.swift
//  TOOTutils
//
//  Created by thor on 2/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI

struct TChooseBlendModeWnd: View {
    
    @Binding public var bm :  BlendMode
    
    init(bm: Binding<BlendMode>) {
        self._bm = bm
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                ForEach(BlendMode.allTypes, id: \.self) { bmt in
                    Section(bmt ) {
                        FlowLayout(alignment: .topLeading) {
                            ForEach(BlendMode.modesByType(bmt)) { it in
                                
                                Button(it.modeName){
                                    bm = it
                                }.padding(.horizontal, 16)
                                    .tint(.gray)
                                    .buttonStyle(.borderedProminent)
                            }
                            
                        }
                    }
                }
                
            }
        }.padding(.vertical, 16)
    }
}

#Preview {
    TChooseBlendModeWnd(bm: .constant(.normal))
}
