//
//  TBlendModeDat.swift
//  TOOTutils
//
//  Created by thor on 2/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import SwiftUI



extension BlendMode {
    
    var descInfo : String {
        switch self {
       // case .normal:  // default case
        case .darken:
             """
            Darken Only creates a pixel that retains the smallest components of the foreground and background pixels.
            """
            
        case .multiply:
            """
            Multiply blend mode multiplies the RGB channel numbers for each pixel from the top layer with the values for the corresponding pixel from the bottom layer. The result is always a darker picture; since each value is less than 1, their product will be less than either of the initial values.
            """
            
          case .colorBurn:
            """
            The Color Burn mode divides the inverted bottom layer by the top layer, and then inverts the result. This darkens the top layer increasing the contrast to reflect the color of the bottom layer. The darker the bottom layer, the more its color is used. Blending with white produces no difference. When top layer contains a homogeneous color, this effect is equivalent to changing the black point to the inverted color.
            """  
            
        case .plusDarker:
            """
            This blend mode simply adds pixel values of one layer with the other then subtracts 1 from the end values.
            """
        
            ///========================================================================
        case .lighten:
            """
            Lighten Only has the opposite action of Darken Only. It selects the maximum of each component from the foreground and background pixels.
            """
            
               case .screen:
            """
            With Screen blend mode the values of the pixels in the two layers are inverted, multiplied, and then inverted again. This yields the opposite effect to multiply, and results in a brighter picture.
            """
            
                 
        case .colorDodge:
            """
            The Color Dodge blend mode divides the bottom layer by the inverted top layer. This lightens the bottom layer depending on the value of the top layer: the brighter the top layer, the more its color affects the bottom layer. Blending any color with white gives white. Blending with black does not change the image.
            """
            
               case .plusLighter:
            """
            This blend mode simply adds pixel values of one layer with the other.
            """
            
            
                ///========================================================================
          
            
            
               case .overlay:
            """
            Overlay combines Multiply and Screen blend modes. The parts of the top layer where the base layer is light become lighter, the parts where the base layer is dark become darker. Areas where the top layer are mid grey are unaffected. An overlay with the same picture looks like an S-curve.
            """
            
               case .softLight:
            """
            Soft light is most closely related to Overlay and is only similar to Hard Light by name. Different for every program.
            """
            
                case .hardLight:
            """
            Hard Light is also a combination of Multiply and Screen. Hard Light affects the blend layer's relationship to the base layer in the same way Overlay affects the base layer's relationship to the blend layer. The inverse relationship between Overlay and Hard Light makes them "commuted blend modes"
            """
              
            
            
                ///========================================================================
          
            
            
                case .difference:
            """
            Difference subtracts the bottom layer from the top layer or the other way round, to always get a positive value. Blending with black produces no change, as values for all colors are 0. (The RGB value for black is (0,0,0).) Blending with white inverts the picture.
            """
            
                case .exclusion:
            """
            Blending with white inverts the base color values, while blending with black produces no change. However, Blending with 50% gray produces 50% gray.
            """
            
            
            
            
                ///========================================================================
          
            
            
                case .hue:
            """
            The Hue blend mode preserves the luma and chroma of the bottom layer, while adopting the hue of the top layer.
            """
            
                case .saturation:
            """
            The Saturation blend mode preserves the luma and hue of the bottom layer, while adopting the chroma of the top layer.
            """   
            
                case .color:
            """
            The Color blend mode preserves the luma of the bottom layer, while adopting the hue and chroma of the top layer.
            """
            
                case .luminosity:
            """
            The Luminosity blend mode preserves the hue and chroma of the bottom layer, while adopting the luma of the top layer.
            """
            
            
            ///========================================================================
      
        
        
            case .sourceAtop:
        """
        The Source Atop and Destination Atop composition modes combine the alpha channels of the source and destination images, before blending the source on top of the destination or vice versa.
        """
            
            case .destinationOver:
        """
        Content is drawn behind the existing canvas content.
        """
              
            case .destinationOut:
        """
        The existing content is kept where it doesn't overlap the new shape.
        """
        
            
            
        default:
            "Normal blend mode....."
        }
        
    }
    
    
    
}

extension BlendMode :   CaseIterable , Identifiable {
    public static var allCases: [BlendMode ]   {
        [.normal , 
         .darken, .multiply, .colorBurn , .plusDarker , // darkening
         .lighten, .screen, .colorDodge, .plusLighter,     // lightening
         .overlay, .softLight, .hardLight,                 // adding contrast
         .difference, .exclusion,                          // inverting
         .hue, .saturation, .color, .luminosity,           // mixing color components
         .sourceAtop, .destinationOver, .destinationOut    // accessing porter-duff modes
        ]
    }
    
    public var id : BlendMode {self}
}

extension BlendMode {
    public static var allTypes : [String] {
        [
            "Normal",
            "Darkening",
            "Lightening",  // 2
            "Adding Contrast",
            "Inverting",
            "Mixing Color",  //5
            "Accessing Porter-duff",
        ]
    }
    
    public static func modesByType(_ typeName: String) -> [BlendMode] {
        switch typeName {
        case BlendMode.allTypes[1]:
            return [.darken, .multiply, .colorBurn, .plusDarker]
        case BlendMode.allTypes[2]:
            return [.lighten, .screen, .colorDodge, .plusLighter]
        case BlendMode.allTypes[3]:
            return [.overlay, .softLight, .hardLight]
        case BlendMode.allTypes[4]:
            return [.difference, .exclusion]
        case BlendMode.allTypes[5]:
            return [.hue, .saturation, .color, .luminosity]
        case BlendMode.allTypes[6]:
            return [.sourceAtop, .destinationOver, .destinationOut]
            
        default:
            break
        }
        
       return [.normal]
    }
    
    
}

extension BlendMode {
   public var modeName : String {
        String(describing: self)
    }
}



