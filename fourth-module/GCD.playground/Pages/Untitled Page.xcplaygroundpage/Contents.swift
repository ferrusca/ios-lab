import Foundation

let queue1 = DispatchQueue(label: "serial.queue1")

print("start sync queue execution")
queue1.sync {
    print("Start task 1 [queue1]...")
    sleep(2)
    print("...Finish task 1 [queue1]")
}


queue1.sync {
    print("Start task 2 [queue1]...")
    sleep(2)
    print("...Finish queue1 task 2 [queue1]")
}

print("end sync queue execution\n")



// serial with async calls
let queue2 = DispatchQueue(label: "my.async.queue")
print("start main execution. Type: async serial")
queue2.async {
    print("Start task 1 [queue2]...")
    sleep(10)
    print("...Finish task 1 [queue2]")
}


queue2.async {
    print("Start task 2 [queue2]...")
    sleep(2)
    print("...Finish task 2 [queue2]")
}

print("end main execution\n")

// concurrent calls
let queue3 = DispatchQueue(label: "my.async.queue", attributes: .concurrent)
print("start main execution. Type: concurrent sync")
queue3.async {
    print("Start task 1 [queue3]...")
    sleep(10)
    print("...Finish task 1 [queue3]")
}


queue3.async {
    print("Start task 2 [queue3]...")
    sleep(2)
    print("...Finish task 2 [queue3]")
}

print("end main execution\n")


// concurrent/async execution

let queue4 = DispatchQueue(label: "serial.queue4", attributes: .concurrent)

print("start async concurrent-queue main execution")
queue4.async {
    print("Start task 1 [queue4]...")
    sleep(2)
    print("...Finish task 1 [queue4]")
}


queue4.async {
    print("Start task 2 [queue4]...")
    sleep(2)
    print("...Finish task 2 [queue4]")
}

print("end async concurrent-queue main execution\n")
