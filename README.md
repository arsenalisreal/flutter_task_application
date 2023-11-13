# flutter_task_application

Application Details
- The application holds the task details which can be created, updated, or deleted from the application
- The application allows the user to delete or edit the task with a single click making it quite user-friendly
- A scroll bar is included to navigate across all the tasks
- All the details are stored in back4App using APIs that are generated from it


LISTING PAGE
- This page utilizes the GET API to fetch the data from back4App
- If the page does not have any data the page will by default display “no data available to display”
- Scrolling is allowed to navigate the lower entries
- It has a pop-up button overlayed at the bottom which will navigate to task adding page
- Edit and delete operations will allow you to perform desired actions on the task
- All the tasks are numbered to make it easier to take care of the numbers that are dynamically  assigned.

![image](https://github.com/arsenalisreal/flutter_task_application/assets/59465406/330b4578-3c36-48e2-8a67-8781fffd3823)


ADD PAGE:

- This page utilizes the POST API to add the data into back4App
- The two fields will consume the task name and task description of each task.
- On clicking submit the post API is invoked and when the response is received as a ‘201’ status code, a successful response is seen on the bottom
- When other HTTP status is seen the footer will display the error
- APIS Involved:	
	POST: https://parseapi.back4app.com/classes/Task_details/

![image](https://github.com/arsenalisreal/flutter_task_application/assets/59465406/8b384d4b-b9e8-47ea-9e05-1b2a6b8d1df1)


UPDATE PAGE:
- This page utilizes the PUT API to add the data into back4App
- The two fields will consume the task name and task description of each task. This reuses the same screen as the create task but displays “Edit task” header.  
- All the values are pre-populated based on the task on which the edit is clicked 
- On clicking submit the post API is invoked and when the response is received as a ‘201’ status code, a successful response is seen on the bottom
- When other HTTP status is seen the footer will display the error
APIS Involved:	
	PUT: https://parseapi.back4app.com/classes/Task_details/$id

