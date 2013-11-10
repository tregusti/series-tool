fs   = require "fs"
path = require "path"

move = require "../../src/api/move"

describe "Move API", ->
  
  options = null
  
  beforeEach ->
    @sandbox = sinon.sandbox.create()
    @sandbox.stub fs
    options =
      help: false
  afterEach  ->
    @sandbox.restore()
    
  context "help", ->
    beforeEach ->
      fs.readFileSync.returns "helptext"
      @sandbox.stub process, "exit"
      @sandbox.stub console, "log"
      
    it "loads the text from a text file", ->
      file = path.join __dirname, "..", "..", "src", "api", "help", "move.txt"
      file = path.resolve file
      move help: true
      fs.readFileSync.should.have.been.calledOnce
      fs.readFileSync.should.have.been.calledWithExactly file, "utf-8"
      
    it "displays help from text file when requested", ->
      move help: true
      console.log.should.have.been.calledOnce
      console.log.should.have.been.calledWithExactly "helptext"
    
    it "exits with code 0", ->
      move help: true
      process.exit.should.have.been.calledOnce
      process.exit.should.have.been.calledWith 0
  
  
  
  context "destination path", ->
    it "is required", ->
      delete options.destination
      f = -> move options
      f.should.throw TypeError
      f.should.throw /destination/i
    
    it "must be an existing path", ->
      fs.existsSync.returns false
      options.destination = "/etc/glubb"
      f = -> move options
      f.should.throw TypeError
      f.should.throw /destination/i
      
  
  
  
  it "moves a Homeland episode as it should", ->
    fs.existsSync.returns true
    fs.readdirSync.withArgs("/dest").returns ["Homeland"]
    file = "/tmp/Homeland.S03E04.720p.HDTV.x264-2HD.mkv"
    
    move
      files: [ file ]
      destination: "/dest"
    
    to = "/dest/Homeland/Season 3/Homeland.S03E04.720p.HDTV.x264-2HD.mkv"
    fs.renameSync.should.have.been.calledOnce
    fs.renameSync.should.have.been.calledWithExactly file, to
    
  
  it "moves a bunch of episodes from different shows as it should", ->
    fs.existsSync.returns true
    fs.readdirSync.withArgs("/to").returns ["Homeland"]
    files = [
      "/from/Homeland.S02E03.720p.HDTV.x264-2HD.mkv",
      "/from/dl/hepp/Sons.of.Anarchy.S06E01.REPACK.720p.HDTV.x264-EVOLVE.mkv"
    ]
    
    move
      files: files
      destination: "/to"
    
    tos = [
      "/to/Homeland/Season 2/Homeland.S02E03.720p.HDTV.x264-2HD.mkv",
      "/to/Sons of Anarchy/Season 6/Sons.of.Anarchy.S06E01.REPACK.720p.HDTV.x264-EVOLVE.mkv"
    ]
    fs.renameSync.callCount.should.equal 2
    fs.renameSync.should.have.been.calledWithExactly file, tos[i] for file, i in files
  
  
  it "should create series directory if needed", ->
    fs.existsSync.withArgs("/to").returns true
    fs.readdirSync.withArgs("/to").returns []
    file = "/Show.S01E01.mkv"
    
    move
      files: [file]
      destination: "/to"
    
    fs.mkdirSync.should.have.been.calledWithExactly "/to/Show"
  
  
  it "should not create series directory if it exists", ->
    fs.existsSync.withArgs("/to").returns true
    fs.readdirSync.withArgs("/to").returns ["show"]
    file = "/Show.S01E01.mkv"
    
    move
      files: [file]
      destination: "/to"
    
    fs.mkdirSync.should.not.have.been.called
  
  
  it "reuses existing directories even if casing differs", ->
    fs.existsSync.withArgs("/to").returns true
    fs.readdirSync.withArgs("/to").returns ["Sons of Anarchy"]
    file = "/tmp/sons.OF.anarChy.S01E01.mkv"
    
    move
      files: [file]
      destination: "/to"
    
    expected = "/to/Sons of Anarchy/Season 1/sons.OF.anarChy.S01E01.mkv"
    fs.renameSync.should.have.been.calledWithExactly file, expected

  