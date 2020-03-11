
In the Beginning I've tried to use a listener to keep the tasks updated, but I was reading unnecessary tasks, and after some thoth
I think the tasks don't need to have a listener, they will be updated only when changing the month or adding/updating a new task,
and only you'll change your task, so I don't need to keep them always updated, but maybe in the future I'll think about some way to 
activate a listener in a specific month

First I've tried to process the schemas with Cloud Functions, I was successful, but the Cloud Function takes a wile to 
create all the tasks, and in this time in the client side I don't know when the tasks are been processed to show a Loading,
for this reason, I'll process the tasks in the client side, latter I'll think about some better way to improve this and send to the server

OK... I know that listening all the tasks is a REALLY BAD THING, but for now I'm more focus on developing the app, latter I'll think
about a better solution to avoid unnecessary reads

