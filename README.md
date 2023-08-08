<h1 align="center">Quake Game Log Parser</h1>

<div align="center"></div>

## Usage
To run the script, use the following command on terminal:
```
ruby lib/parser.rb <log_file_name>
```

Example: there is a log file on the root of the project, so you can run:
```
ruby lib/parser.rb qgames.log
```

## Running tests
1) Install required gems, running the following on terminal (you're going to need [Bundler](https://bundler.io/) installed):
```
bundle install
```

2) Execute the tests with the following terminal command:
```
rspec
```
