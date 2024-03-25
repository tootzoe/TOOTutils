//
//  TColorBlendMainWnd.swift
//  TOOTutils
//
//  Created by thor on 17/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI

struct TColorBlendMainWnd: View {
    
    @State private var isAnimate = false
    @State private var bm : BlendMode = .normal
   

    
    //  @State private var repCnt = Int.max
    
    // @State
    private var minMaxScale = 32.0  //* 6.8
    // @State
    private let maxScale = 32.0 * 6.8
    
    
    @State private var showSheetWnd = false
    
    
    var body: some View {
        
        
        ScrollView{
            
            VStack{
                
                #if false
                Group{
                    
                    ZStack {
                        Image("trees")
                        Rectangle()
                              .fill(.red)
                             // .saturation(0.3)
                               .blendMode(.saturation)
                         //   .colorMultiply(.red)
                               .blur(radius: 0)
                    }
                }
                #endif
                
                TColorWid(isAnimate: $isAnimate , blendMod: $bm)
                    .frame(width: 360   , height: 360  )
                // .background(.white)
                // .border(.red)
                
                
                Button("\(isAnimate ? "Stop" : "Start" ) Animation"){
                    isAnimate.toggle()
                    
                }                    .padding(.horizontal, 16)
                    .buttonStyle(.borderedProminent)
                
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                            
                    }
                    
                    
                    HStack{
                        Text("BlendMode: ")
                            .foregroundStyle(.gray)
                        
                        Button(bm.modeName){
                            showSheetWnd = true
                        }
                        .padding(.horizontal, 18)
                          .foregroundStyle(.white)
                          .overlay {
                              RoundedRectangle(cornerRadius: 24)
                                  .fill(.clear)
                                  .stroke(.gray, lineWidth: 1)
                          }
                            
                        
                        
                        
                        
                    }.font(.title)
                    
                    
                    Text("Description: \n\t\(bm.descInfo)")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                         
                    
                }
                //.border(.red)
                   
                
            }
            //.border(.green)
                
            
        }
        .navigationTitle("Color Blend")
        .sheet(isPresented: $showSheetWnd ) {
            TChooseBlendModeWnd(bm: $bm )
                .presentationDetents([.fraction(0.5)])
        }
        //.padding(   )
//        .task {
//  
//        }
         
    }
      
}
 

extension Array where Element == Int {
    func printAverageAge() {
        let total = reduce(0, +)  // ???????  reduce is always suprised me
        let average = total / count
        print("Average age is \(average)")
    }
}

#Preview {
    TColorBlendMainWnd()
}
