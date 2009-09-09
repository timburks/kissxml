;; test_read.nu
;;  tests for KissXML XML reading.
;;
;;  Copyright (c) 2009 Tim Burks, Neon Design Technology, Inc.
(load "KissXML")

;; ^%$#@! GNUstep. Or alternately, ^%$#@! Apple.
(unless ("foo" respondsToSelector:"stringByReplacingOccurrencesOfString:withString:")
        (class NSString
             (- (id) stringByReplacingOccurrencesOfString:(id) before withString:(id) after is
                (self stringByReplacingString:before withString:after))))

(class DDXMLNode
     (- (id) nodeForXPath:(id) path is
        (set nodes (self nodesForXPath:path error:nil))
        (nodes 0)))

(class TestRead is NuTestCase
     
     (- testYahoo is
        (set string ((NSString stringWithContentsOfFile:"examples/yahoo.xml") stringByReplacingOccurrencesOfString:" xmlns=" withString:" xxxxx="))
        (set doc ((DDXMLDocument alloc) initWithXMLString:string options:0 error:(set error (NuReference new))))
        (set root (doc rootElement))
        (set nodes (doc nodesForXPath:"//ResultSet/Result" error:nil))
        (set titles (array))
        (nodes each:
               (do (node)
                   (set title (node nodeForXPath:"Title"))
                   (titles << (title stringValue))))
        (assert_equal (array "Jamba Juice"
                             "Chef Chu's"
                             "Whole Foods Market"
                             "Los Altos Grill"
                             "Crepe Maker"
                             "Giulietta Italian Foods"
                             "Oreganos Wood Fired Pizza"
                             "Los Altos Coffee Shop"
                             "Sumo Japanese Restaurant"
                             "Applewood Inn Pizza"
                             "Akane Japanese Restaurant"
                             "Armadillo Willy's BBQ"
                             "Estrellita Restaurant"
                             "Hunan Home's Restaurant"
                             "Global Food Technologies"
                             "Spot A Pizza"
                             "Rick's Cafe"
                             "Pet's Delight"
                             "Bella Vita Italian Restaurant"
                             "Peet's Coffee & Tea") titles)))

