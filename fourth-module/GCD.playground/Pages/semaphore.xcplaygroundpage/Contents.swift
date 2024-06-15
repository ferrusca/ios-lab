import Dispatch

let queue = DispatchQueue(label: "my.queue", attributes: .concurrent)
let semaphore = DispatchSemaphore(value: 5)

// group to get notified when all async tasks were done
let myGroup = DispatchGroup()

var songs = [Int]()

for i in 0...14 {
    queue.async(group: myGroup) {
        semaphore.wait()
        print("Downloading semaphore song \(i + 1)")
        sleep(2)
        print("Download complete semaphore song \(i + 1)")
        songs.append(i + 1)
        semaphore.signal()
    }
}

myGroup.notify(queue: .main) {
    print("All songs downloaded (semaphore), they are: \(songs.count)")
}


