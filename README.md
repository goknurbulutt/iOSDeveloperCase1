iOS Developer Case

This project is an iOS application, and its primary goal is to fetch user data from a web service and display it as a list. Each user can be tapped to view their detailed information. The project is written in Swift and developed using UIKit and the MVVM design pattern.

Features

- User List: The application presents user data fetched from an API as a list.
- User Detail: Tapping on a user redirects to a separate screen where detailed information about the user is displayed.
- Loading Indicator: While the data is being fetched, a loading indicator is shown to let users know that the data is loading.
- Error Handling: Network errors or data fetching issues are handled gracefully, and clear error messages are shown to the user.

Technologies Used

- Swift: The main development language used for the application.
- UIKit: The UIKit library is used for building the user interface.
- URLSession: Used for managing network requests and fetching JSON data.
- JSONDecoder: Used to decode JSON data into Swift models.
- MVVM: The Model-View-ViewModel design pattern has been implemented. This structure increases maintainability and testability of the application.
