# Chimera

## About the project

This is an app for concert-goers who wants to keep track of the next events they are going to and save memories of gigs they went to. 

For each event, you can add a cover, and provide the name of the performer, the place where the event is going to happen, and its date. Your events are stored in iCloud so you can access them from all your devices. If you don't want to manually add a new event, you can retrieve the data directly from the Ticketmaster-API.  

For each event you create you can also add memories; the app allows you to provide for each of it vocal recordings, textual notes, and media (both images and videos). You can also edit the cover or the data about the event you have previously provided.

 

## Software Architecture
![Architecture](Docs/Architecture.png)

## Technologies
- SwiftUI
- CloudKit
- PhotoKit
- AVKit
- MVVM Software Architecture

## Lessons Learned
> This project was developed for educational purposes as we are a team of coding students. Some of the topics are used for the first, so maybe there are some mistakes. ;-) We were asked to implement an app of our choice with interface development, persistence and networking while using common software architecture.
- Changing the structure/architecture of a project at the end is difficult. So be careful how you structure your models at the beginning.
-  Because we had to work in parallel on the same code base the use of version control is crucial. For that, we used for the first time Gitflow-Workflow to collaborate effectively.

## License
[GNU General Public License v3.0](LICENSE)
