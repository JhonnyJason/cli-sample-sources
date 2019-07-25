Modules = require "./allmodules.js"

global.allModules = Modules

for name, module of Modules
    module.initialize() 
        
Modules.startupmodule.cliStartup()
    







# Modules = 
#     express: require('express')
#     bodyParser: require('body-parser')
#     fs: require('fs')

# cityArray = require('./city.list.json')
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # definition and initialization
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# port = 3003
# app = Modules.express()
# #=====================================================================================================================
# # functionality
# #=====================================================================================================================
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # insert Data functions
# #=====================================================================================================================
# # base function for setting up the whole Datastructure
# # uses every element in the cityArray and adds the relevant information to the datastruct
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# setUpDataStructure = ->
#     entry = null
#     i = 0
#     while i < cityArray.length
#         #in every iteration information of one Object in the List is going to be set to the datastruct for inseting this entry
#         entry = cityArray[i]
#         dataStruct.currentEntryToInsert = entry
#         dataStruct.currentCityID = entry.id
#         dataStruct.currentCityName = entry.name.toLowerCase() + ', ' + entry.country.toLowerCase()
#         dataStruct.currentSensitiveCityName = entry.name + ', ' + entry.country
#         insertCityEntry()
#         i++
#     dataStruct.initialized = true
#     console.log 'initialized!'
#     return

# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # inserts the current entry which at this point should have been set into the datastructure
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# insertCityEntry = ->
#     #start off @ 0
#     dataStruct.currentCharIndex = 0
#     currentChar = dataStruct.currentCityName.charAt(dataStruct.currentCharIndex)
#     #insert for root entry - cityCount represents the number of cities wich may be reached at this or any child nodes 
#     dataStruct.rootNode.cityCount++
#     #insert stuff for the next Node
#     if !dataStruct.rootNode[currentChar]
#         #create leave(potential node) if there is no appropriate one yet
#         dataStruct.rootNode[currentChar] = cityCount: 1
#     else
#         dataStruct.rootNode[currentChar].cityCount++
#     #otherwise the city is at or at any child of this leave/node
#     #we set a new base node for where we continue to insert the parts of the rest of the names
#     dataStruct.currentNode = dataStruct.rootNode[currentChar]
#     #insert further nodes
#     while dataStruct.currentNode
#         insertNextNode()
#     #clean datastruct
#     dataStruct.currentCharIndex = 0
#     dataStruct.currentNode = null
#     dataStruct.currentEntryToInsert = null
#     return

# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # is called for every character of the object to insert the node for it's seach path
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# insertNextNode = ->
#     dataStruct.currentCharIndex++
#     currentChar = dataStruct.currentCityName.charAt(dataStruct.currentCharIndex)

#   ###
#     console.log("____________________________________________");
#     console.log("City Name: " + dataStruct.currentCityName);
#     console.log("City ID: " + dataStruct.currentCityID);
#     console.log("current Char index: " + dataStruct.currentCharIndex);
#     console.log("current Char: " + currentChar);
#     console.log("- - - - - - - - - - - - - - - - - - - - - - \n");
#   ###

#     if !currentChar
#         # we reached the end
#         dataStruct.currentNode.cityID = dataStruct.currentCityID
#         dataStruct.currentNode.cityName = dataStruct.currentSensitiveCityName
#         dataStruct.currentNode = null
#         #is the break condition to recognize we're through
#         return
#     #create new leave(potential node) if there is no appropriate one yet
#     if !dataStruct.currentNode[currentChar]
#         dataStruct.currentNode[currentChar] = cityCount: 1
#     else
#         dataStruct.currentNode[currentChar].cityCount++
#     #progress to next node
#     dataStruct.currentNode = dataStruct.currentNode[currentChar]
#     return

# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # search functions
# #=====================================================================================================================
# # this will start the loop to go through all relevant nodes
# # when this function is called the seachString has been stored @ datastruct.currentCityName
# # also the maximum number of search results is stored @ resultStruct.maxResults
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# retrieveSearchResults = ->
#     console.log 'retrieveSearchResults'
#     #reset all relevant parameters
#     dataStruct.currentNode = dataStruct.rootNode
#     dataStruct.currentCharIndex = 0
#     resultStruct.results = []
#     #iterating over the searchString
#     currentChar = dataStruct.currentCityName.charAt(dataStruct.currentCharIndex)
#     while currentChar
#         if dataStruct.currentNode[currentChar]
#             dataStruct.currentNode = dataStruct.currentNode[currentChar]
#         else
#             #when we donot find any we have no results and may end the search
#             console.log 'The search String does not fit any results!'
#             return
#         #prepare for next round
#         dataStruct.currentCharIndex++
#         currentChar = dataStruct.currentCityName.charAt(dataStruct.currentCharIndex)
#     #now we have gone through the whole searchString we now should have a search Result
#     if dataStruct.currentNode.cityCount > resultStruct.maxResults
#         #We have too many search results, so we send back none
#         console.log 'there are too many results!'
#         return
#     collectSearchResults()
#     return

# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# #  we have one through the whole searchString and the currentNode is @ the beginning of all search results
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# collectSearchResults = ->
#   console.log 'collectSearchResults'
#   currentNode = dataStruct.currentNode
#   #start recursive depth first search to retreive all search results
#   for key of currentNode
#     # skip loop if the property is from prototype
#     if currentNode.hasOwnProperty(key)
#       console.log 'key: \'' + key + '\' / value: \'' + currentNode[key] + '\''
#       #if there is a cityID this node represents a complete city
#       if key == 'cityID' and currentNode[key]
#         resultStruct.results.push
#           cityID: currentNode.cityID
#           cityName: currentNode.cityName
#       #every key length 1 is pointing to a child node
#       if key.length == 1
#         dataStruct.currentNode = currentNode[key]
#         collectSearchResults()
#   return

# app.use Modules.bodyParser.urlencoded(extended: false)
# app.use Modules.bodyParser.json()
# # for acces control allowing acces to the necessary services - - - - - 
# app.use (req, res, next) ->
#   allowedOrigins = [
#     'http://localhost:3002'
#     'http://localhost:3002/weatherforecast'
#     'http://localhost:3003'
#     'http://localhost:3003/citysearch'
#     'http://weather.aurox.at'
#     'http://weather.aurox.at/weatherforecast'
#     'http://citysearch.aurox.at'
#     'http://citysearch.aurox.at/citysearch'
#   ]
#   origin = req.headers.origin
#   console.log 'header origin was: ' + origin
#   if allowedOrigins.indexOf(origin) > -1
#     res.setHeader 'Access-Control-Allow-Origin', origin
#   res.header 'Access-Control-Allow-Methods', 'POST, OPTIONS'
#   res.header 'Access-Control-Allow-Headers', 'Content-Type'
#   next()
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # Global variables
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# dataStruct = 
#   rootNode:
#     cityCount: 0
#     cityID: 0
#     cityName: ''
#   currentEntryToInsert: null
#   currentCityName: ''
#   currentSensitiveCityName: ''
#   currentCityID: 0
#   currentCharIndex: 0
#   currentNode: null
#   initialized: false
# resultStruct = 
#   maxResults: 30
#   results: []
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # Routes
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# app.post '/citysearch', (req, res) ->
#   console.log 'post /citysearch'
#   console.log req.body
#   #first set the maxResults and searchString so the retrieveSearchResults algorithm knows about it
#   if req.body.maxResults
#     resultStruct.maxResults = req.body.maxResults
#   else
#     resultStruct.maxResults = 10
#   if req.body.searchString
#     dataStruct.currentCityName = req.body.searchString.toLowerCase()
#   else
#     dataStruct.currentCityName = ''
#   #kick off search, which terminates synchronously
#   retrieveSearchResults()
#   res.send resultStruct.results
#   return
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setUpDataStructure()
# cityArray = null
# app.listen port
