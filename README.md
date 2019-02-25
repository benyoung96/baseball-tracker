# Baseball Tracker
Baseball tracker is an application that allows a user to keep scoring during a baseball game. The user will be able to select their faorite MLB team, set their everyday line up, and set their rotation. There will be the ability to edit the full roster and/or line up if an injury or trade a occurs.

### Development Todo
- [X] Create OnBoardingController that subclass UIPageViewController that allows for navigation between the Teams, LineUp and Rotation Controllers
- [ ] Finish implementation and design of TeamsController
- [ ] Finish implementation and design of LineUpController
- [ ] Finish implementation and design of RotationController
- [ ] Create design for the ScheduleController
- [ ] Create design for view controller where the scoring will be taking place
- [ ] Write a generic NetworkManager so I don't have to write the same thing for every network request
- [ ] Create a generic UITableViewCell, TeamsCell and PlayerCell are pratically the same thing

### Things I Learn
 - Protocols to improve consistency through the code base
 - URLSession with the network layer that I wrote
 - UIPageViewController
 - Core Data
 - Utilizing extensions to standard library class/protocols 
 - Coordinator design pattern so handle my applications navigation
