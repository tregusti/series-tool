child_process = require "child_process"

cli = require "../../src/cli"
api = require "../../src/api"

describe "CLI argument parser with", ->
  beforeEach -> @sandbox = sinon.sandbox.create()
  afterEach -> @sandbox.restore()
  
  context "subtitle command", ->
    url = null
    beforeEach ->
      @sandbox.stub api, "subtitle", -> url
    
    it "should invoke subtitle API once", ->
      cli.run _: [ "subtitle" ]
      api.subtitle.should.have.been.called.once
    
    it "should invoke subtitle API with filename", ->
      cli.run _: [ "subtitle", "filename.mkv" ]
      api.subtitle.should.have.been.calledWith "filename.mkv"
      
    it "should strip away any path part", ->
      cli.run _: [ "subtitle", "/path/to/file/filename.mkv" ]
      api.subtitle.should.have.been.calledWith "filename.mkv"
    
    it "should not try to open in browser if no URL was given", ->
      @sandbox.stub child_process, "exec"
      cli.run _: [ "subtitle", "filename.mkv" ]
      child_process.exec.should.not.have.been.called
      
      
    it "should open the URL from the API", ->
      # Arrange
      url = "http://example.com/subs"
      @sandbox.stub child_process, "exec"
      
      # Act
      cli.run _: [ "subtitle", "filename.mkv" ]
      
      # Assert
      child_process.exec.should.have.been.called.once
      child_process.exec.should.have.been.calledWith "open \"#{url}\""
      
