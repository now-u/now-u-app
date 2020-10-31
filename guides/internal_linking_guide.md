# Routing

In order to be able to link to different sections of the app, we need to define a schema which describes where you want to go. These will be in the form of links starting with the "internal:".

# The recipie for an internal link

1. Start with "internal:"
2. Add a destination. All possible destination will be listen in this file: https://github.com/now-u/now-u-app/blob/dev/lib/routes.dart

For example if you want to navigate home, first you need to find this line in the above file

`static const home = "home";`

This tells you that name of the route for the home page is "home".

Therefore you link would now be 

"internal:home"

1. Add any extra data you need. If no paramterers are required then the above link is fine as is. Parameters can be added to a link such as an id of an action (if you go to the actionInfo page). For now the possible paramterers are:

- id

The format for paramterers are as follows

"internal:home&param1=thing?param2=thing2?param3=thing3"

So if you want to go to the actionInfo page for action with id 1 then you would need this:

"internal:actionInfo&id=1"
