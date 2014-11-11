sessionId = (id) ->
   '__tagList__' + id

# Create a global helper object

@TagList =

   # Returns the current value of a list given its ID
   get: (id) ->
      Session.get sessionId(id)

##

Template.tagList.created = ->

   listId = sessionId @data.id
   initialValue = @data.defaultItems or []
   
   # Store the edited list in a session so that it's preserved across hot pushes
   
   if not Session.get 'listId'
      Session.setDefault listId, initialValue

##

Template.tagList.destroyed = ->

   # Clear the session so that it can be used for new routes
   delete Session.keys[sessionId @data.id]

##

Template.tagList.helpers

   tagListItems: ->
      Session.get sessionId @id
            
##

Template.tagList.rendered = ->

   # Register for JQuery events
   
   input = $(@find('input'))
   button = $(@find('button.add-tag-list-button'))
   
   self = this
   
   # Add a new item when either the button is clicked, return is pressed or an item is selected
   # from the typeahead menu
   
   addItem = (item) ->
      itemLC = item.toLowerCase().trim()
      if itemLC is "" then return
      
      currentItems = Session.get sessionId(self.data.id)
      
      currentItemsLC = currentItems.filter (i) -> i.toLowerCase() == itemLC
      
      if currentItemsLC.length is 0
         currentItems.push item
         Session.set sessionId(self.data.id), currentItems
         input.val('')
         input.typeahead?('close')
   
   button.click ->
      addItem input.val() 
         
   input.keypress (e) ->
      if e.which == 13
         e.preventDefault()
         addItem input.val()
         
   input.bind 'typeahead:selected', (e, obj, set) ->
      addItem obj.value
      
##

Template.tagListItem.rendered = ->
 
   listData = Template.parentData(1)
 
   # Remove a list item from the list when it's clicked on
 
   $(@find('.tag-list-item')).click (e) ->
      e.preventDefault()
      value = $(@).prop('name')
      current = Session.get sessionId(listData.id)
      current = _.filter current, (x) -> x != value
      Session.set sessionId(listData.id), current