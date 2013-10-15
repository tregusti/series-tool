subtitle = require "../../lib/api/subtitle"

describe "Subtitle API", ->
  baseurl = "http://subscene.com/subtitles"
  
  it "should be a function", ->
    (expect subtitle).to.be.a "function"
  
  it "should return null when input is a non match", ->
    (expect subtitle "Nothing good").to.be.null
  
  it "should return null when input is null", ->
    expect(subtitle null).to.be.null
  
  context "with scene releases as input", ->
    
    it "should handle simple names", ->
      file = "Homeland.S03E01.720p.HDTV.x264-IMMERSE.mkv"
      result = subtitle file
      (expect result).to.contain "/homeland-"

    it "should handle shows with multi word names", ->
      file = "Sons.of.Anarchy.S06E03.720p.HDTV.x264-IMMERSE.mkv"
      result = subtitle file
      (expect result).to.contain "/sons-of-anarchy-"
      
    it "should extract season name", ->
      file = "Sons.of.Anarchy.S06E03.720p.HDTV.x264-IMMERSE.mkv"
      (expect subtitle file).to.contain "-sixth-"
  
    it "should combine parts correctly", ->
      result = subtitle "Homeland.S02E05.720p.HDTV.x264-IMMERSE.mkv"
      expected = baseurl + "/homeland-second-season"
      (expect result).to.equal expected
      