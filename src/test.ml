type canvas 
type html_element

module Proc = 
struct
  
  type processing 
  external processing : processing = "" [@@bs.module]
    external height : processing -> float = "height" [@@bs.get] 
    external width : processing -> float = "width" [@@bs.get]
    external background : processing -> int -> unit = "background" [@@bs.send]
   
    external size : processing -> int -> int -> unit = "size" [@@bs.send]
   
    external draw : processing -> (unit -> unit) -> unit = "draw" [@@bs.set]
    external setup : processing -> (unit -> unit) -> unit = "setup" [@@bs.set]
   
    external stroke : processing -> int -> unit = "stroke" [@@bs.send]
   
    external ellipse : processing -> float -> float -> int -> int -> unit = "ellipse" [@@bs.send]
   
    external fill : processing -> int -> unit = "fill" [@@bs.send]
   
    external create_processing : html_element -> (processing -> unit) -> unit = "Processing" [@@bs.new]
end

let x = ref 100.0
let y = ref 100.0
let xspeed = ref 1.0
let yspeed = ref 1.0

let sketch (p:Proc.processing) =

  let s () = 
    Proc.size p 640 360;
    Proc.background p 255;
    ()
  in	

  let f () = 	
    Proc.background p 255;
    let h = Proc.height p in 
    let w = Proc.width p in
    x := !x +. !xspeed;
    y := !y +. !yspeed;
    if ((!x > w) || (!x < 0.0)) then
      xspeed :=  !xspeed *. -1.0 ;
    if ((!y > h) || (!y < 0.0)) then
      yspeed := !yspeed *. -1.0;
    ignore(Proc.ellipse p !x !y 16 16)

  in
  Proc.setup p s;
  Proc.draw p (function () -> f ());
  ()

class type document = 
  object 
    method getElementById : string -> html_element
  end[@bs]

type doc = document Js.t

external doc : doc = "document" [@@bs.val]

let v = doc##getElementById("canvas1")

let proc = Proc.create_processing v sketch
