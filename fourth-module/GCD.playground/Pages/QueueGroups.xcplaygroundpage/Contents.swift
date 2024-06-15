import Foundation

let myGroup = DispatchGroup()
let queue = DispatchQueue(label: "my.queue", attributes: .concurrent)

// songs are represented by integers
var songs = [Int]()

for i in 0...14 {
    queue.async(group: myGroup) {
        print("Downloading song \(i + 1)")
        sleep(2)
        print("Download complete song \(i + 1)")
        songs.append(i + 1)
    }
}

// once all tasks were completed, this gets executed
myGroup.notify(queue: .main) {
    print("All songs downloaded, they are: \(songs.count)")
    
}
