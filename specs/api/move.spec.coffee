fs   = require "fs"
path = require "path"

move = require "../../src/api/move"

describe "Move API", ->
  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach  -> @sandbox.restore()
    
  context "help", ->
    beforeEach ->
      @sandbox.stub fs, "readFileSync", -> "helptext"
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