api = require "../../src/api"

describe "Public API", ->
  
  it "should expose the subtitle api", ->
    (expect api.subtitle).to.equal require "../../src/api/subtitle"
  
  it "should expose the move api", ->
    (expect api.move).to.equal require "../../src/api/move"