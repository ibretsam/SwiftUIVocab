# NewVocab - French Vocabulary Learning App

A modern iOS application for learning French vocabulary with an interactive and engaging user interface. The app connects to a gRPC server to fetch vocabulary data and presents it in an intuitive, swipeable card format.

## Demo
<img src="Demo/demo.gif" alt="Demo" title="Demo" height="560" width="259"/>

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

Initially, the app will use the mock data in `MainViewServices`. If you have your own gRPC server (I haven't finished it yet so it's not published for now), follow the instructions below:
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
