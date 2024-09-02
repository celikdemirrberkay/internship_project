# Albayrak Group Internship Project


## Getting Started

Run the following codes in terminal to run the project :

```bash
  dart run build_runner build
```


## Environment Variable

To run this project you will need to add the following environment variables to the .env file in the assets/env folder

`BASE_URL = "API BASE URL"`

## Project Structure
The foldering of the project is as follows ->
 - Core
 - Feature
 - Model
 - Service

 ## Service Structure
Null management in projects has always been a challenge for me. For this reason, I managed null in the service layer of the project. I completely eliminated the responsibility of null to the view and view-model. Thanks to the Resource class, I return exception type in case of error or null data. In this way, operations on the view and view-model side become much easier. I share the resource class below.

```dart
sealed class Resource<T> {
  const Resource({this.data, this.exceptionType});

  final T? data;

  final ExceptionTypes? exceptionType;
}

class SuccessState<T> extends Resource<T> {
  const SuccessState(T data) : super(data: data);
}

class ErrorState<T> extends Resource<T> {
  const ErrorState(ExceptionTypes type, [T? data]) : super(data: data, exceptionType: type);
}

class LoadingState<T> extends Resource<T> {
  const LoadingState() : super();
}
```

## Screenshots

<img width="200" alt="1" src="https://github.com/user-attachments/assets/c148c448-c547-4f18-a649-6171868d6b6a">
<img width="200" alt="2" src="https://github.com/user-attachments/assets/e219c28a-2b07-415e-aae7-d7e1274b1392">
<img width="200" alt="3" src="https://github.com/user-attachments/assets/17fb4603-8551-4887-bb09-da63cc3247a4">
<img width="200" alt="Screenshot 2024-08-16 at 14 40 06" src="https://github.com/user-attachments/assets/71641591-7967-4bd9-ba28-a33170512df4">


