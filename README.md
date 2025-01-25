# Vocab 

A modern iOS application for learning French vocabulary with an interactive and engaging user interface. The app connects to a gRPC server to fetch vocabulary data and presents it in an intuitive, swipeable card format.

<p align="center">
  <img src="Demo/AppIcon~ios.png" alt="App Icon" title="App Icon" width="120" height="120"/>
</p>

<p align="center">
  <img src="Demo/demo.gif" alt="Demo" title="Demo" width="300"/>
</p>

## ✨ Features

- Interactive card-based vocabulary learning
- Detailed word information with pronunciation
- Comprehensive conjugation tables for verbs
- Modern and intuitive user interface

## 🛠 Technical Stack

- **Framework**: SwiftUI
- **iOS Version**: iOS 13.0+
- **Data Persistence**: SwiftData
- **Network**: gRPC-Swift
- **Architecture**: MVVM
- **Backend Communication**: Protocol Buffers

## 🚀 Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/ibretsam/SwiftUIVocab.git
```

### 2. Install dependencies

If you're using the command line:
```bash
cd NewVocab
swift package resolve
```

If you're using Xcode, it will automatically resolve the package dependencies when you open the project. If not, you can manually resolve them by going to File > Packages > Resolve Package Versions.

### 3. Generate Proto files
```bash
protoc ./Vocab.Api/Protos/vocab.proto \
--swift_opt=Visibility=Public \
--swift_out=./NewVocab/NewVocab/Generated \
--grpc-swift_opt=Visibility=Public \
--grpc-swift_out=./NewVocab/NewVocab/Generated \
--proto_path=./Vocab.Api/Protos
```

### 4. Configuration

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
