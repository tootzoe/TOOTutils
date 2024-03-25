//
//  File.swift
//  TOOTutils
//
//  Created by thor on 26/2/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//



import Foundation










// Function to get the local IP address using a shell command
func getLocalIP() -> String {
    #if os(macOS)
    // Create a new Process instance
    let task = Process()
    // Set the launch path for the process to the Zsh shell executable
    task.launchPath = "/bin/zsh"
    // Set the arguments for the shell command to retrieve the IP address using ifconfig, grep, and awk
    task.arguments = ["-c", "ifconfig | grep 'inet ' | grep -Fv 127.0.0.1 | awk '{print $2; exit}'"]

    // Create a Pipe to capture the standard output of the task
    let pipe = Pipe()
    // Set the standard output of the task to the created Pipe
    task.standardOutput = pipe
    // Launch the process
    task.launch()

    // Read the data from the Pipe's file handle (output of the shell command)
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    // Convert the data to a UTF-8 encoded string and trim whitespace and newline characters
    if let ip = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) {
        return ip // Return the obtained IP address
    }
    #endif
    return "" // Return an empty string if IP address couldn't be obtained
}

















