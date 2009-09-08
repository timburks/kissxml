;; simple example showing use of KissXML from Nu
;; note the hack required to disable namespaces

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

;; Yahoo Local Search API results
(set string ((NSString stringWithContentsOfFile:"examples/yahoo.xml") stringByReplacingOccurrencesOfString:" xmlns=" withString:" xxxxx="))
(set doc ((DDXMLDocument alloc) initWithXMLString:string options:0 error:(set error (NuReference new))))
(set root (doc rootElement))
(set nodes (doc nodesForXPath:"//ResultSet/Result" error:nil))
(nodes each:
       (do (node)
           (set title (node nodeForXPath:"Title"))
           (puts title)
           (puts (node description))
           (puts "---")))

(function spaces (count)
     (set s "")
     (count times:(do (i) (set s (+ s " "))))
     s)

(function expand (node level)
     (puts (+ (spaces level) (node name)))
     (puts (+ (spaces level) (node stringValue)))
     (puts (+ (spaces level) (node level)))
     (puts (+ (spaces level) (node XPath)))
     (if (node respondsToSelector:"attributes")
         (puts (+ (spaces level) ((node attributes) description))))
     ((node children) each:
      (do (child)
          (expand child (+ level 1)))))

; uncomment to see everything
;(expand root 0)
