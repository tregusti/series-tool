cli = require "../../src/cli"
api = require "../../src/api"

describe "CLI move", ->
  beforeEach ->
    @sandbox = sinon.sandbox.create()
    @sandbox.stub api
    
  afterEach ->
    @sandbox.restore()
  
  it "doesn't invoke API when no destination is given", ->
    cli.run _: [ "move", "/path/filename.mkv" ]
    api.move.should.not.have.been.called
  
  it "doesn't invoke API when no files are given", ->
    cli.run
      _           : [ "move" ],
      destination : "/to/"
    
    api.move.should.not.have.been.called
  
  context "with valid params", ->
    beforeEach ->
      @args = 
        _           : [ "move", "/path/filename.mkv" ],
        destination : "/some/path"
      
    it "should invoke API with filename", ->
      cli.run @args
      api.move.should.have.been.calledWithMatch
        destination : "/some/path"
        files       : [ "/path/filename.mkv" ]
    
