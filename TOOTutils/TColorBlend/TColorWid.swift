//
//  TColorWid.swift
//  TOOTutils
//
//  Created by thor on 2/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI

struct TColorWid: View {
    
    @Binding  public  var isAnimate : Bool
    @Binding public var blendMod : BlendMode
    
    @Environment(\.colorScheme) private var crSch
 
     private var minMaxScale = 32.0 * 6.8
 
    
    private var stepVal = 0.1
    
    init(isAnimate: Binding< Bool >  , blendMod : Binding<BlendMode>) {
        self._isAnimate = isAnimate
        self._blendMod = blendMod
          
    }
    
    
    
    @ViewBuilder
    func mkCrCircle(_ w: Double, _ h : Double , _ s : Double) -> some View {
        ZStack{
            let divNum = 6.0
            let scale = w/10.0*8.0
            Circle()
                .fill(.red)
             .frame(width:  s * scale)
             .offset(x: 0, y:  -h/divNum )
                .blendMode(blendMod)
            
            Circle()
                .fill(.green)
             .frame(width: s * scale)
             .offset(x: -w/divNum, y: h/divNum)
                .blendMode(blendMod)
            
            Circle()
                .fill(.blue)
             .frame(width: s * scale)
             .offset(x:  w/divNum, y: h/divNum)
                .blendMode(blendMod)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  
    
    
    
    var body: some View {
        
        TimelineView(.periodic(from: .now, by: isAnimate ?  0.1 : Double.infinity )) { ctx in
            

            let t = ctx.date.timeIntervalSince1970
           // let  minMaxScale = minMaxScale  + stepVal
          //  let w =  (t * 10 ) //.rounded() // .truncatingRemainder(dividingBy: 360)
            let s = abs(  sin(t ) )
            
             
            ZStack {
                
                Checkerboard(rows: 4, columns: 5)
                    .fill(crSch == .dark ? .white : .black)
                
                
                GeometryReader  { geometry in
                    mkCrCircle(geometry.size.width, geometry.size.height, s)
                }
                .frame(maxWidth: .infinity , maxHeight:  .infinity)
                 
  
            }
             .rotationEffect(Angle(degrees: (t * 10).rounded()) )
            
            
        }
    }
}


struct Checkerboard: Shape {
    let rows: Int
    let columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

#Preview {
    TColorWid(isAnimate: .constant(true), blendMod: .constant(.screen))
}
