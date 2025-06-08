include <BOSL2/std.scad>
include <BOSL2/beziers.scad>
use <scad-utils/transformations.scad>


$fn=32;
unit= 19.05;
split_angle = -7;
plate_angle = -5; //deg
plate_height = 12;

topPlateThickness = 9;
swithchCutoutFillet = 2;
layerCount = 30;
splineRes = 30;


/*Build */

up(1)PCB(.0);
color("grey", alpha= .5)up(1)scale(1.00)SwitchPlate(.51);
//
TopPlatform(debug =true, outline= false, a=.5,  center= "");
//
BottomPlatform(debug =true, a=.5);


//Bottom Pattern Cut
//difference(){
//  up(0)color("DeepSkyBlue",alpha=.25)import("74_Bottom_Case.stl");
//  down(.25)import("Bottom_Pattern.stl");
//     }
//     fwd(33)cyl(d=3,50);
//}

/*End Build*/


  //bez stuff unify sturcture to document style?  add string name for
bezNodesCenter = let(boundaryOff = unit/2+9, cornerOff= 7, u = unit) [ // add point name for looping text and smooth type
              switch_left(row= 0, col = 0, offsets = [.5*u, .25*u]+[0,boundaryOff]),  //p0
              switch_left(row= 0, col = 2, offsets = [   0,     0]+[-boundaryOff,boundaryOff]),  //p1
              
              switch_left(row= 0, col = 4, offsets = [-boundaryOff + cornerOff, boundaryOff]), //p2
              switch_left(row= 0, col = 4, offsets = [-boundaryOff, boundaryOff-cornerOff]), //p3
              
              switch_left(row= 2, col = 4, offsets = [-boundaryOff, -boundaryOff+cornerOff]), //p4
              switch_left(row= 2, col = 4, offsets = [-boundaryOff+cornerOff, -boundaryOff]), //p5
              
              switch_left(row= 2, col = 4, offsets = [ .5*u, -.25*u]+[0, -boundaryOff]+[-2,1]), //p6


              switch_left(row= 3.25, col = 2, offsets = [-.125*u,0]+[-boundaryOff,-boundaryOff]), //p7
              switch_left(row= 3,    col = 0, offsets =   [1.6*u, 0]+[ 0,-boundaryOff-0]) //p8
              
             ];
bezNodesTop = let(boundaryOff = unit/2+7, cornerOff= 7, u = unit, adjust=1) [ // add point name for looping text and smooth type
//              [0, u/2-1],  //start
              switch_left(row= 0, col = 0, offsets = [1.25*u, .25*u]+[0,boundaryOff]+[-6,-.75]),  //p0
              switch_left(row= 0, col = 2, offsets = [   0,     0]+[-boundaryOff,boundaryOff]),  //p1
              
              switch_left(row= 0, col = 4, offsets = [-boundaryOff + cornerOff, boundaryOff]), //p2
              switch_left(row= 0, col = 4, offsets = [-boundaryOff, boundaryOff-cornerOff]), //p3
              
              switch_left(row= 2, col = 4, offsets = [-boundaryOff, -boundaryOff+cornerOff]), //p4
              switch_left(row= 2, col = 4, offsets = [-boundaryOff+cornerOff, -boundaryOff]), //p5
              
              switch_left(row= 2, col = 4, offsets = [boundaryOff-.25*u, -boundaryOff]), //p6
              switch_left(row= 2, col = 4, offsets = [boundaryOff+.87*u, -boundaryOff+5]), //p7
              switch_left(row= 2, col = 4, offsets = [boundaryOff+4.5*u, -boundaryOff+5]) //p8
//              [0, -u*4 -boundaryOff+3]
             ];
bezNodesBottom = let(boundaryOff = unit/2+7, cornerOff= 7,frontcornerOff= 5, u = unit) [ // add point name for looping text and smooth type
//              [0, u/2-1],  //start
              switch_left(row= 0, col = 0, offsets = [.5*u, .25*u]+[0,boundaryOff]+[-4,-4]),  //p0
              switch_left(row= 0, col = 2, offsets = [   0,     0]+[-boundaryOff,boundaryOff]+[4,-4]),  //p1
              
              switch_left(row= 0, col = 4, offsets = [-boundaryOff + frontcornerOff, boundaryOff]+[8,-3]), //p2
              switch_left(row= 0, col = 4, offsets = [-boundaryOff, boundaryOff-frontcornerOff]+[3,-8]), //p3
              
              switch_left(row= 2, col = 4, offsets = [-boundaryOff, -boundaryOff+cornerOff]+[4,10]), //p4
              switch_left(row= 2, col = 4, offsets = [-boundaryOff+cornerOff, -boundaryOff]+[10,4]), //p5
              
              switch_left(row= 2, col = 4, offsets = [ .5*u, -.25*u]+[0, -boundaryOff]+[2,7]), //p6
              
              switch_left(row= 3.25, col = 2, offsets = [-.125*u,0]+[-boundaryOff,-boundaryOff]+[6,8]), //p7
              switch_left(row= 3,    col = 0, offsets =   [.5*u, 0]+[ 0,-boundaryOff-0]+[-8,8]) //p8
              
//              [0, -u*4 -boundaryOff+3]
             ];
             
bezNodesBottomInternal = let(boundaryOff = unit/2+4, cornerOff= 7, u = unit) [ // add point name for looping text and smooth type
//              [0, u/2-1],  //start
              switch_left(row= 0, col = 0, offsets = [.5*u, .25*u]+[0,boundaryOff]+[-4,-4]),  //p0
              switch_left(row= 0, col = 2, offsets = [   0,     0]+[-boundaryOff,boundaryOff]+[4,-4]),  //p1
              
              switch_left(row= 0, col = 4, offsets = [-boundaryOff + cornerOff-2, boundaryOff]+[8,-3]), //p2
              switch_left(row= 0, col = 4, offsets = [-boundaryOff, boundaryOff-cornerOff+2]+[3,-8]), //p3
              
              switch_left(row= 2, col = 4, offsets = [-boundaryOff, -boundaryOff+cornerOff]+[4,10]), //p4
              switch_left(row= 2, col = 4, offsets = [-boundaryOff+cornerOff, -boundaryOff]+[10,4]), //p5
              
              switch_left(row= 2, col = 4, offsets = [ .5*u, -.25*u]+[0, -boundaryOff]+[2,7]), //p6
              
              switch_left(row= 3.25, col = 2, offsets = [-.125*u,0]+[-boundaryOff,-boundaryOff]+[6,8]), //p7
              switch_left(row= 3,    col = 0, offsets =   [.5*u, 0]+[ 0,-boundaryOff-0]+[-8,8]) //p8
              
//              [0, -u*4 -boundaryOff+3]
             ];           
bezNodesTransTop = [ // add point name for looping text and smooth type
              ["linear", 1], //p0
              ["linear", 0], //p1
              ["linear", 0], //p2
              ["linear", 0], //p3
              ["linear", 1], //p4
              ["linear", 0], //p5
              ["linear", 0], //p6
              ["linear", 0], //p7
              ["linear", 2], //p8
             ];  
 
bezNodesTransBottom = [ // add point name for looping text and smooth type
              ["linear", 1], //p0
              ["linear", 0], //p1
              ["linear", 0], //p2
              ["linear", 0], //p3
              ["linear", 1], //p4
              ["linear", 0], //p5
              ["linear", 0], //p6
              ["linear", 0], //p7
              ["linear", 0], //p8
             ];  
 bezControlCenter= let(p0= -10, hrz=-7,  p1= 25, p2 = 45, p4=135, p6 =150, p7= 110, p8=0) [  //scalar, angler
                          [5, p0], [0, 0], [10, hrz+180], //p0 x
                          [10, hrz], [0, 0], [10, 180+p1], //p1 x
                          
                          [10, hrz], [0, 0], [ 1, p2+hrz+180], //p2 x
                          [ 1, p2+hrz], [0, 0], [10, 270+hrz], //p3 x
                          
                          [10, 90+hrz], [0, 0], [2, p4+hrz+180], //p4 x
                          [2, p4+hrz], [0, 0], [5, hrz], //p5 x
                          
                          [5, p6], [0, 0], [5, p6+180], //p6 
                          [5, p7], [0, 0], [10, hrz], //p7
//                          [10, 180+hrz], [0, 0], [10, p8] //p8
                          [10, 180+hrz], [0, 0], [3, hrz] //p8
                        ];  
 bezControlTop= let(p0= 0, hrz=-7,  p1= 25, p2 = 45, p4=135, p6 =150, p7= 110, p8=0) [  //scalar, angler
                          [3.5, hrz], [0, 0], [10, hrz+180], //p0 x
                          [10, hrz], [0, 0], [10, 180+p1], //p1 x
                          
                          [15, hrz], [0, 0], [ 1, p2+hrz+180], //p2 x
                          [ 1, p2+hrz], [0, 0], [15, 270+hrz], //p3 x
                          
                          [10, 90+hrz], [0, 0], [2, p4+hrz+180], //p4 x
                          [2, p4+hrz], [0, 0], [5, hrz], //p5 x
                          
                          [5, hrz+180], [0, 0], [20, 360+hrz], //p6 
                          [1, hrz+180+90], [0, 0], [10, hrz], //p7
                          [10, 180+hrz], [0, 0], [5, hrz] //p8
                        ];  
 bezControlBottom= let(p0= 0, hrz=-7,  p1= 30, p2 = 45, p4=135, p6 =150, p7= 130, p8=0) [  //scalar, angler
                          [1, p0], [0, 0], [10, hrz+180], //p0 x
                          [10, hrz], [0, 0], [8, 180+p1], //p1 x
                          
                          [5, hrz], [0, 0], [ 1, p2+hrz+180], //p2 x
                          [ 1, p2+hrz], [0, 0], [10, 270+hrz], //p3 x
                          
                          [10, 90+hrz], [0, 0], [2, p4+hrz+180], //p4 x
                          [2, p4+hrz], [0, 0], [3, hrz], //p5 x
                          
                          [3, p6], [0, 0], [3, p6+180], //p6 
                          [5, p7], [0, 0], [10, hrz], //p7
                          [10, 180+hrz], [0, 0], [10, p8] //p8
                        ];  
bezControlTransTop = [ // add point name for looping text and smooth type
              ["linear", 1], //p0 Prev
              ["linear", 0], //p0 Null
              ["linear", 1], //p0 Next
              
              ["linear", 1], //p1 Prev
              ["linear", 1], //p1 Null
              ["linear", 1], //p1 Next
              
              ["linear", 1], //p2 Prev
              ["linear", 1], //p2 Null
              ["linear", 1], //p2 Next
              
              ["linear", 1], //p3 Prev
              ["linear", 1], //p3 Null
              ["linear", 1], //p3 Next
              
              ["linear", 1], //p4 Prev
              ["linear", 1], //p4 Null
              ["linear", 1], //p4 Next
              
              ["linear", 1], //p5 Prev
              ["linear", 1], //p5 Null
              ["linear", 1], //p5 Next
              
              ["linear", 1], //p6 Prev
              ["linear", 1], //p6 Null
              ["linear", 1], //p6 Next
              
              ["linear", 1], //p7 Prev
              ["linear", 1], //p7 Null
              ["linear", 1], //p7 Next
              
              ["linear", 1], //p8 Prev
              ["linear", 1], //p8 Null
              ["linear", 1], //p8 Next
             ];  

bezControlTransBottom = [ // add point name for looping text and smooth type
              ["linear", 1], //p0 Prev
              ["linear", 1], //p0 Null
              ["linear", 1], //p0 Next
              
              ["linear", 1], //p1 Prev
              ["linear", 1], //p1 Null
              ["linear", 1], //p1 Next
              
              ["linear", 1], //p2 Prev
              ["linear", 1], //p2 Null
              ["linear", 1], //p2 Next
              
              ["linear", 1], //p3 Prev
              ["linear", 1], //p3 Null
              ["linear", 1], //p3 Next
              
              ["linear", 1], //p4 Prev
              ["linear", 1], //p4 Null
              ["linear", 1], //p4 Next
              
              ["linear", 1], //p5 Prev
              ["linear", 1], //p5 Null
              ["linear", 1], //p5 Next
              
              ["linear", 1], //p6 Prev
              ["linear", 1], //p6 Null
              ["linear", 1], //p6 Next
              
              ["linear", 1], //p7 Prev
              ["linear", 1], //p7 Null
              ["linear", 1], //p7 Next
              
              ["linear", 1], //p8 Prev
              ["linear", 1], //p8 Null
              ["linear", 1], //p8 Next
             ];  
             
function bez_node_loop(struct = bezNodesCenter) = 
  concat(
    struct,
    xflip(Flip(struct)), 
    [struct[0]]//close loop
  );
function bez_trans_loop(struct = bezNodesTransTop) = 
  concat(
    struct,
    Flip(struct), 
    [struct[0]]//close loop
  );                        
function bez_control_loop (struct = bezControlCenter) = 
  concat(
    struct, 
    (Flip(-struct)),
    select(struct,[0:2])
  );
  
function bez_ctrans_loop (struct = bezControlTransTop) = 
  concat(
    struct, 
    Flip(struct),
    select(struct,[0:2])
  );
/*Rearranging Bezier data*/

function control_vec (n,b) = [ n[0]+b[0]*cos(b[1]), n[1]+b[0]*sin(b[1]) ];                               
function bezier_input (n,c) = [for(i = [1:len(c)-2])let(j=floor(i/3)) control_vec(n[j],c[i])];// for bez N=3

module skinBezOutline (initNode, initControl, finNode, finControl, transNode, transControl, layer, height, rot) {
  skin([for(i = count(layer)) 
    transform(translation([0,0,height*i/(layer-1)])*rotation([rot*i/(layer-1),0,0]),
    bezpath_curve(
      bezier_input(smooth_mix(bez_node_loop(initNode), bez_node_loop(finNode), i/(layer-1),bez_trans_loop(transNode)),
                   smooth_mix(bez_control_loop(initControl), bez_control_loop(finControl), i/(layer-1),bez_ctrans_loop(transControl))
      ), splinesteps = splineRes, N = 3, endpoint=false
    ))
  ], slices= 0);
}

module TopPlatform (debug = true, outline=false, a = 1, center = "knob") {
  module debugOutline (Node, Control) {
    debug_bezier(bezier_input(bez_node_loop(Node), bez_control_loop(Control)),N=3, width = 1);
   }

  if(outline == true)
//  for(i= count(len(bez_node_loop())-1)) 
  let(i=0){
    global_origin()color("gold",alpha=1)up(10)move(bez_node_loop()[i])text(text = str(i), size = 5, halign ="center");
   }
   
  if(debug == true)global_origin(){
//    color("red", alpha=1)up(1.4)zrot(180)mount_hole_plate(rad=1.5875/2*3.05, depth=1.5, rounding = .75); //1/16" o-rings with some compression room
    color("lime", alpha= a)SwitchCutout(topPlateThickness);
//    color("snow", alpha= a)xflip()SwitchCutout(topPlateThickness);
      if(center == "key")color("blue")CenterSwitchCutout(topPlateThickness);
      else if(center == "knob")color("blue")CenterKnobCutout(topPlateThickness);
    color("gold", alpha= a)skin([plate_cutout(radius =0, [.35,.35]), plate_cutout(radius=0,[.35,.35])], z=[-.01,1.5], slices=2);
    color("red", alpha=a)up(1.25)zrot(0)mount_hole_case(rad=2.6, depth=2.70);
    color("black", alpha=1)up(0)zrot(180)mount_hole_plate(rad=1.5875/2*1.05, depth=7); //1/16" Dia 1/4" len Acetal Pin

//    color("red", alpha=a)up(2)zrot(0)mount_hole_case(rad=3.5/2, depth=4.01);
  }
 
  global_origin() difference(){
   union()color("cyan", alpha=.5)let(lip=5){
     up(topPlateThickness-lip)skinBezOutline(bezNodesCenter, bezControlCenter, bezNodesTop, bezControlTop ,bezNodesTransTop, bezControlTransTop, layerCount, lip, 0); 
       
     skinBezOutline(bezNodesCenter, bezControlCenter, bezNodesCenter, bezControlCenter ,bezNodesTransTop, bezControlTransTop, layerCount, topPlateThickness-lip, 0); 
      // center key location 
    }
    if(debug == false){
//      #color("lime")SwitchCutout(topPlateThickness,.25,[.25,.25]);
      color("lime")SwitchCutout(topPlateThickness);
      if(center == "key")color("blue")CenterSwitchCutout(topPlateThickness);
      else if(center == "knob")color("blue")CenterKnobCutout(topPlateThickness);
      color("gold")skin([plate_cutout(radius =0, [.35,.35]), plate_cutout(radius=0,[.35,.35])], z=[-0.001,1.6], slices=2);
      color("red", alpha=a)up(1.25)zrot(0)mount_hole_case(rad=2.6, depth=2.7);
      color("black", alpha=1)up(0)zrot(180)mount_hole_plate(rad=1.5875/2*1.05, depth=7); //1/16" Dia 1/4" len Acetal Pin
      color("red", alpha=1)up(1.6)zrot(180)mount_hole_plate(rad=1.5875/2*3.05, depth=1.5, rounding = 0); //1/16" o-rings with some compression room

//      color("red", alpha=a)up(2)zrot(0)mount_hole_case(rad=3.5/2, depth=4.01);
    }
  }
  
  if(outline == true)global_origin(){
    debugOutline(bezNodesCenter, bezControlCenter);
    up(topPlateThickness)debugOutline(bezNodesTop, bezControlTop);
    down(plate_height)xrot(-plate_angle)debugOutline(bezNodesBottom, bezControlBottom);
  }
}

module BottomPlatform (debug = true, a = 1) {
  cutDepth= 8.25;
  
  module USB_port () {
    move([0,1.25,-7.1])xrot(90){
      let(sli=30, x=-10.5)skin(
        [for (i=lerpn(0,1,sli)) 
          transform(translation([0,0,x*i]) * rotation([smooth_start(0,0,i,1),0,0]), 
          fwd(-5/2, p=trapezoid(h=smooth_start(4.75+5,4.75+8,i,2), w1=smooth_start(14.675,20,i,3), w2=smooth_start(14., 15,i,3), rounding = .05+i*.25)))], slices= 0);
     let(sli=30, x=3)skin(
        [for (i=lerpn(0,1,sli)) 
          transform(translation([0,0,x*i]) * rotation([smooth_start(0,0,i,1),0,0]), 
          fwd(-5/2, p=trapezoid(h=smoothest_step(4.75+5,4.75+2.5,i), w1=smooth_start(14.675,14.675,i,3), w2=smooth_start(14., 14,i,3), rounding = .05)))], slices= 0);
     }
  }
  
  global_origin(){
     if(debug == true){
      color("lime", alpha=a)USB_port()
      color("red", alpha=1)down(.65)zrot(180)mount_hole_plate(rad=1.5875/2*3.05, depth=1.5, rounding = 0); //1/16" o-rings with some compression room
      color("teal",alpha=a)down(cutDepth-.05)BottomCutout(cutDepth, [0.35,0.35]);
      color("snow",alpha=a)xflip()down(cutDepth-.05)BottomCutout(cutDepth, [0.35,0.35]);
      color("gold",alpha=a)skin([plate_cutout(radius =0, [.35,.35]), plate_cutout(radius=0,[.35,.35])], z=[0.05,-.5], slices=2);
      color("red", alpha=a)up(-.5)zrot(0)mount_hole_case(rad=2.6, depth=2.5);
      color("black", alpha=1)up(0)zrot(180)mount_hole_plate(rad=1.5875/2*1.05, depth=6.5); //1/16" Dia 1/4" len Acetal Pin

     }
     

    difference(){
     union(){
       color("darkgray", alpha=a)
          skinBezOutline(bezNodesCenter, bezControlCenter, bezNodesCenter, bezControlCenter ,bezNodesTransBottom, bezControlTransBottom, layerCount, -2, 0); 
       color("RoyalBlue", alpha=a)
          down(2)skinBezOutline(bezNodesCenter, bezControlCenter, bezNodesBottom, bezControlBottom, bezNodesTransBottom, bezControlTransBottom, layerCount, -plate_height+2, -plate_angle); 
      // center key location 
      }
      if(debug == false){
        color("teal",alpha=1)down(cutDepth-.05)BottomCutout(cutDepth,[0.35,0.35]);
        color("gold",alpha=1)skin([plate_cutout(radius =0, [.35,.35]), plate_cutout(radius=0,[.35,.35])], z=[0.05,-1.25], slices=2);
        color("red", alpha=a)up(-.5)zrot(0)mount_hole_case(rad=2.6, depth=2);
        color("lime", alpha=a)USB_port();
        color("red", alpha=1)down(.65)zrot(180)mount_hole_plate_mod()cyl(r=1.5875/2*3.05, h=1.5, rounding1 = .75); //1/16" o-rings with some compression room
        
        color("black", alpha=1)up(0)zrot(180)mount_hole_plate(rad=1.5875/2*1.05, depth=6); //1/16" Dia 1/4" len Acetal Pin

      }
    }

  }
}


module BottomPattern () {
       color("Red")
          down(10.75)skinBezOutline(bezNodesBottomInternal, bezControlBottom, bezNodesBottomInternal, bezControlBottom, bezNodesTransBottom, bezControlTransBottom, 2, -1, -plate_angle); 
//initNode, initControl, finNode, finControl, transNode, transControl, layer, height, rot
}

module SwitchCutout (topPlateThickness, chamfer= 2, buffer=[.5,.5]) {
   // todos 
   swithchCutoutFillet = 2;
   cutoutRadiusAdjust = 1;

      //chamfering the cut out top 
   skin([top_switch_cutout(0,[.5,.5]), top_switch_cutout(0, buffer), top_switch_cutout(-.5, [chamfer,chamfer])], z=[-.01,topPlateThickness-chamfer,topPlateThickness+.01 ], slices=4);
   xflip()skin([top_switch_cutout(0,[.5,.5]), top_switch_cutout(0, buffer), top_switch_cutout(-.5, [chamfer,chamfer])], z=[-.01,topPlateThickness-chamfer,topPlateThickness+.01 ], slices=4);
}

module CenterSwitchCutout (topPlateThickness, chamfer= 2, centerSwitch=true) {
 
  if(centerSwitch==true){
      move([0,-15,0]){
          skin([                   
                [[10,10],[9.99, 10],[-9.99, 10],[-10,10],[-12.25,-10],[-12.249, -10],[12.249, -10],[12.25,-10]],
                
                [[10.25, 14.9],[0.01, 13.5],[-0.01, 13.5],[-10.25, 14.9],
                [-14.75, -23.75],[-0.01, -30.5],[0.01, -30.5],[14.75,-23.75]]
                ] ,
                z= [topPlateThickness-chamfer,
                    topPlateThickness+.01 ], slices=0, sampling= "segment"
          );
          skin([rect([unit,unit],rounding=.5), rect([unit+.5,unit+.5],rounding=.5)],
                z= [-.01,topPlateThickness-chamfer,], slices=1, sampling= "segment");   
                
       fwd(unit)cyl(d=2,20);
       fwd(unit+10)cyl(d=2,20);
      }
  }
}

module CenterKnobCutout (topPlateThickness, chamfer= 2) {

//
  move([0,-15,0]){  
     skin([                   
             [[10,10],[9.99, 10],[-9.99, 10],[-10,10],[-12.25,-10],[-12.249, -10],[12.249, -10],[12.25,-10]],
                
             [[10.25, 14.3],[0.01, 13.25],[-0.01, 13.25],[-10.25, 14.25],
              [-14.75, -24.75],[-0.01, -30],[0.01, -30],[14.75,-24.75]] 
           ],
           z= [topPlateThickness-chamfer,
               topPlateThickness+.01 ], slices=0, sampling= "segment"
     );
     up(2.01)cyl(d=25, h=10);
     fwd(unit)cyl(d=1,20);
     fwd(unit+10)cyl(d=1,20);      
  }
  //pcb cutout
}
 module BottomCutout (Thickness, buffer=[0,0]) {  
   swithchCutoutFillet = 2;
   cutoutRadiusAdjust = 1;

      //chamfering the cut out top 
   skin([bottom_pcb_cutout(buffer), bottom_pcb_cutout(buffer)], z=[0,Thickness], slices=4);
}

module mount_hole_plate (rad=1, depth=1,rounding=0) { 
  mount_inner_top = [11.584,0];
  mount_outer_top = [94.2255,-5.8305];
  mount_inner_bot = [21.821,79.792];
  mount_outer_bot = [87.9175,53.9767];

  loc = [mount_inner_top, mount_inner_bot, mount_outer_top, mount_outer_bot];
  MoveIterate(loc)cyl(r=rad, depth, rounding = rounding);
}
module mount_hole_plate_mod (rad=1, depth=1,rounding=0) { 
  mount_inner_top = [11.584,0];
  mount_outer_top = [94.2255,-5.8305];
  mount_inner_bot = [21.821,79.792];
  mount_outer_bot = [87.9175,53.9767];

  loc = [mount_inner_top, mount_inner_bot, mount_outer_top, mount_outer_bot];
//  #MoveIterate(loc)children();
  hull(){
    move(loc[0])children();
    move(loc[1])children();
  }
  hull(){
    move(xflip(loc[0]))children();
    move(xflip(loc[1]))children();
  }
  hull(){
    move(loc[2])children();
    move(loc[3])children();
  }
  hull(){
    move(xflip(loc[2]))children();
    move(xflip(loc[3]))children();
  }
}
module mount_hole_case (rad=1, depth=1) { 
  mount_outer_top = switch_left(row= 0, col = 4, offsets = [-.5*unit, .76*unit]);
  mount_outer_cen = switch_left(row=  1, col = 4, offsets = [-.78*unit, 0]);
  mount_outer_bot = switch_left(row= 2, col = 4, offsets = [-.5*unit, -.77*unit]);
  
  mount_inner_top = switch_left(row= 0, col = 5, offsets = [0*unit, 4*unit]);
  mount_center_top = switch_left(row= 0, col = 5, offsets = [-2.75*unit, 4*unit]);
  mount_inner_bot = switch_left(row= 0, col = 5, offsets = [-.75*unit, -.75*unit]);
  mount_inner_bot2 = switch_left(row= 0, col = 5, offsets = [-2.75*unit, -.75*unit]);
  mount_center_bot = [0, -83];
  
  loc = [mount_inner_top, mount_center_top, mount_inner_bot, mount_inner_bot2, mount_outer_top,mount_outer_cen, mount_outer_bot];
  MoveIterate(loc)cyl(r=rad, depth);
  move(mount_center_bot)cyl(r=rad, depth);
}

//switch cutout       
function topSwitchOutline (buffer=[0,0]) = let(off=.50)[
  switch_left(row= 0, col = 0, offsets = [ off*unit, off*unit]+buffer),
  switch_left(row= 0, col = 2, offsets = [ off*unit, .25*unit]+buffer),
  switch_left(row= 0, col = 2, offsets = [ off*unit, off*unit]+buffer),
  switch_left(row= 0, col = 2, offsets = [ -off*unit, off*unit]+xflip(buffer)),
  switch_left(row= 0, col = 2, offsets = [ -off*unit, .25*unit]+xflip(buffer)),
  switch_left(row= 0, col = 3, offsets = [ -off*unit, off*unit]+xflip(buffer)),
  switch_left(row= 0, col = 3, offsets = [ -off*unit, .25*unit]+xflip(buffer)),
  switch_left(row= 0, col = 4, offsets = [ -off*unit, off*unit]+xflip(buffer)),
  switch_left(row= 2, col = 4, offsets = [ -off*unit, -off*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 2, col = 4, offsets = [ off*unit, -off*unit]+yflip(buffer)),
  switch_left(row= 2, col = 4, offsets = [ off*unit, -.25*unit]+yflip(buffer)),
  switch_left(row= 0, col = 5, offsets = [ -2.625*unit, .5*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 0, col = 5, offsets = [ -2.625*unit, -off*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 3, col = 0, offsets = [ off*unit, -off*unit]+yflip(buffer))
];

outlineFillet = [1,1,1,1,1,1,1,1,1,1, 1,1,1,1];

function bottomOutline (buffer=[0,0]) = [
  [-7, 8.5]+xflip(buffer),
  [-7,-2.4]-yflip(buffer),
  switch_left(row= 0, col = 0, offsets = [ .5*unit-.5, .5*unit-.75]+buffer),
  switch_left(row= 0, col = 0, offsets = [ .5*unit-1, .5*unit+1.5]+buffer),
  switch_left(row= 0, col = 2, offsets = [ .5*unit, .5*unit]+buffer),
  switch_left(row= 0, col = 2, offsets = [ -.5*unit, .5*unit]+xflip(buffer)),
  switch_left(row= 0, col = 3, offsets = [ -.5*unit, .5*unit]+xflip(buffer)),
  switch_left(row= 0, col = 4, offsets = [ .50*unit, .51*unit]+xflip(buffer)),
  
  switch_left(row= 0, col = 4, offsets = [ -.51*unit, .51*unit]+xflip(buffer)),
  switch_left(row= 2, col = 4, offsets = [ -.50*unit, -.50*unit-.5]+mirror([1,1,0],buffer)),
  switch_left(row= 2, col = 4, offsets = [ .5*unit, -.5*unit-.5]+yflip(buffer)),
  switch_left(row= 2, col = 3, offsets = [ -.5*unit, -.5*unit-2.25]+yflip(buffer)),
  switch_left(row= 0, col = 5, offsets = [ -2.675*unit, .5*unit-.75]+mirror([1,1,0],buffer)),
  
  switch_left(row= 0, col = 5, offsets = [ -2.675*unit, -.5*unit-.75]+mirror([1,1,0],buffer)),
  switch_left(row= 0, col = 5, offsets = [ .25*unit, -.5*unit-.75]+yflip(buffer)),
  
  xflip(switch_left(row= 0, col = 5, offsets = [ .25*unit, -.5*unit-.75]+yflip(buffer))),
  xflip(switch_left(row= 0, col = 5, offsets = [ -2.675*unit, -.5*unit-.75]+mirror([1,1,0],buffer))),

  xflip(switch_left(row= 0, col = 5, offsets = [ -2.675*unit, .5*unit-.75]+mirror([1,1,0],buffer))),
  xflip(switch_left(row= 2, col = 3, offsets = [ -.5*unit, -.5*unit-2.25]+yflip(buffer))),
  xflip(switch_left(row= 2, col = 4, offsets = [ .5*unit, -.5*unit-.5]+yflip(buffer))),
  xflip(switch_left(row= 2, col = 4, offsets = [ -.50*unit, -.50*unit-.5]+mirror([1,1,0],buffer))),
  xflip(switch_left(row= 0, col = 4, offsets = [ -.51*unit, .51*unit]+xflip(buffer))),

  xflip(switch_left(row= 0, col = 4, offsets = [ .50*unit, .51*unit]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 3, offsets = [ -.5*unit, .5*unit]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 2, offsets = [ -.5*unit, .5*unit]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 2, offsets = [ .5*unit, .5*unit]+buffer)),
  xflip(switch_left(row= 0, col = 0, offsets = [ .5*unit-1, .5*unit+1.5]+buffer)),
  xflip(switch_left(row= 0, col = 0, offsets = [ .5*unit-.5, .5*unit-.75]+buffer)),
  xflip([-7,-2.5]-yflip(buffer)),
  xflip([-7, 8.5]+xflip(buffer))
];

bottomFillet = [3,1,1,1,1,10,2, 2,4,3,1,2, 2,2,1,
                1,2,2,      2,1,3,4,2, 2,10,1,1,1,1,3];
                
function plateOutline (buffer=[0,0]) = let(off=.52) [
  switch_left(row= 0, col = 0, offsets = [ .73*unit,.35*unit]+buffer),
  switch_left(row= 0, col = 0, offsets = [ .73*unit,.74*unit]+buffer),
  switch_left(row= 0, col = 0, offsets = [ .53*unit, .72*unit]+buffer),
  switch_left(row= 0, col = 0, offsets = [ .32*unit, (off+.03)*unit]+buffer),
  switch_left(row= 0, col = 2, offsets = [ off*unit, .3*unit]+buffer),
  switch_left(row= 0, col = 2, offsets = [ (off)*unit, (off)*unit+.5]+buffer),
  switch_left(row= 0, col = 2, offsets = [ -off*unit, off*unit+.5]+xflip(buffer)),
  switch_left(row= 0, col = 2, offsets = [ -off*unit, .3*unit]+xflip(buffer)),
  switch_left(row= 0, col = 3, offsets = [ -.87*unit, (off+.03)*unit]+xflip(buffer)),

  switch_left(row= 0, col = 4, offsets = [ -(off+.035)*unit, .52*unit]+xflip(buffer)),
  switch_left(row= 2, col = 4, offsets = [ -(off+.035)*unit, -.56*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 2, col = 4, offsets = [ .5*unit, -.56*unit]+yflip(buffer)),
  
  switch_left(row= 0, col = 5, offsets = [ -2.78*unit, .0*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 0, col = 5, offsets = [ -2.78*unit, -.53*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 3, col = 0, offsets = [ .30*unit, -.53*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 3, col = 0, offsets = [ .5*unit, -.75*unit]+mirror([1,1,0],buffer)),
  switch_left(row= 3, col = 0, offsets = [ .71*unit, -.75*unit]+yflip(buffer)),
  switch_left(row= 3, col = 0, offsets = [ .71*unit, -.1*unit]+yflip(buffer)),

  xflip(switch_left(row= 3, col = 0, offsets = [ .71*unit, -.1*unit]+yflip(buffer))),
  xflip(switch_left(row= 3, col = 0, offsets = [ .71*unit, -.75*unit]+yflip(buffer))),
  xflip(switch_left(row= 3, col = 0, offsets = [ .5*unit, -.75*unit]+mirror([1,1,0],buffer))),
  xflip(switch_left(row= 3, col = 0, offsets = [ .30*unit, -.53*unit]+mirror([1,1,0],buffer))),
  xflip(switch_left(row= 0, col = 5, offsets = [ -2.78*unit, -.53*unit]+mirror([1,1,0],buffer))),
  xflip(switch_left(row= 0, col = 5, offsets = [ -2.78*unit, .0*unit]+mirror([1,1,0],buffer))),
 
  xflip(switch_left(row= 2, col = 4, offsets = [ .5*unit, -.56*unit]+yflip(buffer))),
  xflip(switch_left(row= 2, col = 4, offsets = [ -(off+.035)*unit, -.56*unit]+mirror([1,1,0],buffer))),
//  xflip(switch_left(row= 0, col = 4, offsets = [ -off*unit, .55*unit]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 4, offsets = [ -(off+.035)*unit, .52*unit]+xflip(buffer))),

//  xflip(switch_left(row= 0, col = 3, offsets = [ -.87*unit, .30*unit]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 3, offsets = [ -.87*unit, (off+.03)*unit]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 2, offsets = [ -off*unit, .3*unit]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 2, offsets = [ -off*unit, off*unit+.5]+xflip(buffer))),
  xflip(switch_left(row= 0, col = 2, offsets = [ off*unit, off*unit+.5]+buffer)),
  xflip(switch_left(row= 0, col = 2, offsets = [ off*unit, .3*unit]+buffer)),
  xflip(switch_left(row= 0, col = 0, offsets = [ .32*unit, (off+.03)*unit]+buffer)),
  xflip(switch_left(row= 0, col = 0, offsets = [ .53*unit, .72*unit]+buffer)),
  xflip(switch_left(row= 0, col = 0, offsets = [ .73*unit,.74*unit]+buffer)),
  xflip(switch_left(row= 0, col = 0, offsets = [ .73*unit,.35*unit]+buffer))
];

plateFillet =   [.5, 2, 2, 1,1.5,1.5,1.5,1.5, 3, 1, /*3,*/ 1, 1.5, 1, /*1,3, 1,*/1, 1,2,2.5,1,
               1,2.5,2,1, 1,/*1,3,1,*/ 1, 1.5, 1,/*3,*/ 1, 3, 1.5,1.5,1.5,1.5,1, 2,2,.5];

                
function top_switch_cutout (radius=0, buffer= [0,0]) = flatten([for(i=count(len(topSwitchOutline()),-1))
             arc(10, corner=(select(topSwitchOutline(buffer), [i, i+1,i+2])), r= outlineFillet[i+1]+radius)]);
             
function bottom_pcb_cutout (buffer= [0,0]) = flatten([for(i=count(len(bottomOutline()),-1))
             arc(10, corner=(select(bottomOutline(buffer), [i, i+1,i+2])), r= bottomFillet[i+1])]);
             
function plate_cutout (radius=0, buffer= [0,0]) = flatten([for(i=count(len(plateOutline()),-1))
             arc(10, corner=(select(plateOutline(buffer), [i, i+1,i+2])), r= plateFillet[i+1]+radius)]);


///non criticals
module global_origin () {
  up(plate_height)xrot(plate_angle)children();
}
 module MoveIterate (locations, mir=true) {
  for(i = idx(locations))move(locations[i])children();
  for(i = idx(locations))move(xflip(locations[i]))children();
}                   

function switch_left (row= 0, col = 0, offsets=[0,0]) = zrot( split_angle, p= 
    let(origin = [-22.95, -12.85], column_origins =[[0,0],[-1,0],[-2,1/4],[-3,0],[-4,-1/4],[-1/8,-3]]*unit) origin+column_origins[col]+[0,-row*unit]+offsets);


module EC_housing () {
 up(4.75/2)cuboid([18.25, 18.5, 4.75],rounding = 2, except=BOTTOM ); // bot
 up(5)cuboid([14, 14.5, 10],chamfer = 1, except=BOTTOM ); // bot
 up(11.5/2)cyl(d=10.5, 11.5);
} 

module SwitchPlate (height=0) {
  global_origin()down(0.5+height)fwd(15.19)linear_extrude(1)import("plate_36keys-Edge_Cuts.dxf");
}

module PCB (height=0) {
  global_origin(){
    down(2.6+4.75+height)fwd(15)color("red",alpha = .5)import("capy_pcb.stl");
    
    color("gold")down(2.75+4.75+height+1.35)fwd(-5)hull(){ //usb
       left(4)xrot(90)cyl(d=3.,6.75);
       right(4)xrot(90)cyl(d=3.,6.75);
    }
//    color("gold")down(2.75+4.75+height)fwd(-5)let(rnd=2){
////      hull(){
//       left(4)xrot(90)cyl(d=3.5,rounding1= -rnd,10);
//       left(-4)xrot(90)cyl(d=3.5,rounding1= -rnd,10);
//       fwd(-10)xrot(90)cyl(d=3.5,20);
//    }
  }
}

//helper function
function Flip (singArry) = [for(i = [len(singArry)-1:-1:0]) singArry[i]];   
  
function Mix (a, b, u, pows)= (1-pow(u, pows))*a+pow(u, pows)*b;

function smooth_start (init, fin,u, power) = 
  (1-pow(u,power))*init + pow(u,power)*fin; 

function smooth_stop (init, fin, u, power) = 
  (fin-init)*(1-pow(1-u,power))+init; 

function smooth_step (init, fin, u) = 
  (fin - init)*(pow(u,2)*3 - pow(u,3)*2) + init; 

function smoother_step (init, fin, u) = 
  (fin - init)*(6*pow(u,5) - 15*pow(u,4) +10* pow(u,3)) + init; 

function smoothest_step (init, fin, u) = 
  (fin - init)*(-20*v_pow(u,7) + 70*v_pow(u,6) - 84*v_pow(u,5) +35*v_pow(u,4)) + init; 
  
function smooth(init, fin, u, p=1, selector="linear") = 
    selector=="linear"? lerp(init, fin, u): selector=="step"? smooth_step(init, fin, u): selector=="steper"? smoother_step(init, fin, u): selector=="stepest"? smoothest_step(init, fin, u): selector=="start"?smooth_start (init, fin, u, p):selector=="stop"?smooth_stop (init, fin, u, p):0;

function circularX (init, fin, t, steps) = 
  init+fin-(fin)*cos(90/steps*t); 
  
function invCircularX (init, fin, t, steps) = 
  (fin)*cos(90/steps*t) + init; 

function circularY (init, fin, t, steps) = 
  (fin)*sin(90/steps*t) +init; 
  
function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (n = [0:step])let (t = rot1 + n*(rot2-rot1)/step) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function smooth_peak(init, cent, fin, u, transitionPoint) = t <= transitionPoint ?  smooth_step(init,cent, t, transitionPoint) :  smooth_step(cent, fin, t-transitionPoint, steps-transitionPoint);

function Fade (Arry1, Arry2, u, pows) =len(Arry1)==len(Arry2) ? [for(i = [0:len(Arry1)-1]) (1-pow(u, pows))*Arry1[i]+pow(u, pows)*Arry2[i]]: [[0,0]];

function Fade_s (Arry1, Arry2, u, pows=1) =len(Arry1)==len(Arry2) ? [for(i = [0:len(Arry1)-1])
  (Arry2[i]-Arry1[i])*(1-pow(1-u, pows))+Arry1[i]]: [[0,0]];

function smooth_mix (Arry1, Arry2, u, select) = len(Arry1)==len(Arry2) ? [for(i = [0:len(Arry1)-1]) smooth(Arry1[i], Arry2[i], u, select[i][1], select[i][0]) ]: [[0,0]];


