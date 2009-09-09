;; test_create.nu
;;  tests for KissXML XML reading.
;;
;;  Copyright (c) 2009 Tim Burks, Neon Design Technology, Inc.
(load "KissXML")


(function element (name)
     ((DDXMLElement alloc) initWithName:name))

(class TestCreate is NuTestCase
     
     
     (- testFamily is
        
        (set archie (element "father"))
        (archie setStringValue:"Archie")
        (archie addAttribute:(DDXMLNode attributeWithName:"gender" stringValue:"male"))
        
        (set edith (element "mother"))
        (edith setStringValue:"Edith")
        (edith addAttribute:(DDXMLNode attributeWithName:"gender" stringValue:"female"))
        
        (set gloria (element "daughter"))
        (gloria setStringValue:"Gloria")
        (gloria addAttribute:(DDXMLNode attributeWithName:"gender" stringValue:"female"))
        
        (set michael (element "son-in-law"))
        (michael setStringValue:"Michael")
        (michael addAttribute:(DDXMLNode attributeWithName:"gender" stringValue:"male"))
        
        (set family (element "family"))
        (family setChildren:(array archie edith gloria michael))
        
        (set expected <<-END
     <family><father gender="male">Archie</father><mother gender="female">Edith</mother><daughter gender="female">Gloria</daughter><son-in-law gender="male">Michael</son-in-law></family>
     END)
        (assert expected (family XMLString))))
