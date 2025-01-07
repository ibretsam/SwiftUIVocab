# NewVocab - French Vocabulary Learning App

A modern iOS application for learning French vocabulary with an interactive and engaging user interface. The app connects to a gRPC server to fetch vocabulary data and presents it in an intuitive, swipeable card format.

## Features

[![Watch the video](https://raw.githubusercontent.com/ibretsam/SwiftUIVocab/main/Demo/thumbnail.png)](https://raw.githubusercontent.com/ibretsam/SwiftUIVocab/main/Demo/UIDemo.mov)

## Technical Stack

- **Framework**: SwiftUI
- **iOS Version**: iOS 13.0+
- **Data Persistence**: SwiftData
- **Network**: gRPC-Swift
- **Architecture**: MVVM
- **Backend Communication**: Protocol Buffers

## Setup Instructions

1. Clone the repository
```bash
git clone https://github.com/yourusername/NewVocab.git
```

2. Install dependencies
```bash
cd NewVocab
swift package resolve
```

3. Generate Proto files
```bash
protoc ./Vocab.Api/Protos/vocab.proto \
--swift_opt=Visibility=Public \
--swift_out=./NewVocab/NewVocab/Generated \
--grpc-swift_opt=Visibility=Public \
--grpc-swift_out=./NewVocab/NewVocab/Generated \
--proto_path=./Vocab.Api/Protos
```

4. Configuration
Copy the sample config file:
```bash
cp NewVocab/NewVocab/Config/config.sample.json NewVocab/NewVocab/Config/config.json
```
Update `config.json` with your server details:
```json
{
    "server_host": "your.server.host",
    "server_port": 5002
}
```
Or you can switch to use mock data in `MainViewServices`
