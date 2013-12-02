subject = require "../../src/api/parser"

describe "File parsing", ->
  context "show name", ->
    it "swaps dot for spaces", ->
      result = subject.parse "Sons.of.Anarchy.S00E00.mkv"
      result.should.have.property "show", "Sons of Anarchy"
    
    it "removes accents", ->
      result = subject.parse "Grey`s.Anatomy.S00E00.mkv"
      result.should.have.property "show", "Greys Anatomy"
    
  it "parses out the season number", ->
    result = subject.parse "Sons.of.Anarchy.S04E01.HDTV-EVOLVE.mkv"
    result.should.have.property "season", 4
  
  it "parses out the episode number", ->
    result = subject.parse "Sons.of.Anarchy.S04E09.HDTV-EVOLVE.mkv"
    result.should.have.property "episode"
    result.episode.should.have.property "from", 9
    result.episode.should.have.property "to", 9
  
  it "parses out the episode number from a double episode", ->
    result = subject.parse "Sons.of.Anarchy.S04E09-10.HDTV-EVOLVE.mkv"
    result.episode.should.have.property "from", 9
    result.episode.should.have.property "to", 10
  
  it "exposes the file name", ->
    result = subject.parse "/path/to/Sons.of.Anarchy.S04E09-10.HDTV-EVOLVE.mkv"
    result.should.have.property "file", "Sons.of.Anarchy.S04E09-10.HDTV-EVOLVE.mkv"
    
  it "exposes the full path name", ->
    result = subject.parse "/path/to/Sons.of.Anarchy.S04E09-10.HDTV-EVOLVE.mkv"
    result.should.have.property "path", "/path/to/Sons.of.Anarchy.S04E09-10.HDTV-EVOLVE.mkv"
    
  it "returns null if parsing is not successful", ->
    should.not.exist subject.parse "/path/to/Bad.name.mkv"
  
  it "handles mixed casing in season and episode", ->
    result = subject.parse "/path/to/Sons.of.Anarchy.s03e07.HDTV-EVOLVE.mkv"
    result.should.have.property "season", 3
    result.episode.should.have.property "from", 7
    result.episode.should.have.property "to", 7

  it "parsers out the year if present", ->
    result = subject.parse "/path/to/The.Newsroom.2012.S01E01.HDTV-EVOLVE.mkv"
    result.should.have.property "year", 2012
