subtitle = require "../../lib/subtitle"

describe "Subtitle API", ->
  baseurl = "http://subscene.com/subtitles"
  
  context "url method", ->
    it "should exist", ->
      (expect subtitle.url).to.be.a "function"
    
    context "with scene releases as input", ->
      
      it "should handle simple names", ->
        file = "Homeland.S03E01.720p.HDTV.x264-IMMERSE.mkv"
        result = subtitle.url file
        (expect result).to.contain "/homeland-"
  
      it "should handle shows with multi word names", ->
        file = "Sons.of.Anarchy.S06E03.720p.HDTV.x264-IMMERSE.mkv"
        result = subtitle.url file
        (expect result).to.contain "/sons-of-anarchy-"
        
      it "should extract season name", ->
        file = "Sons.of.Anarchy.S06E03.720p.HDTV.x264-IMMERSE.mkv"
        result = subtitle.url file
        (expect result).to.contain "-sixth-"
    
      it "should return null when not matching", ->
        (expect subtitle.url "Hello.mkv").to.be.null
        
      it "should combine parts correctly", ->
        result = subtitle.url "Homeland.S02E05.720p.HDTV.x264-IMMERSE.mkv"
        expected = baseurl + "/homeland-second-season"
        (expect result).to.equal expected
        