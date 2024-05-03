import UIKit

// Protocols: they're a way of encapsulate
// A protocol can be seen as a contract

struct Person {
    let name: String
    let age: Int
    let holidays: Int
}

// Adding a protocol to make printTable function reusable
protocol TabularDataSource {
    // The getter says that this prop is readonly, so it doesnt include set
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String
    func getCell(row: Int, column: Int) -> String
}

// The return type here says that Department is conforming the protocol TabularDataaSource
struct Department: TabularDataSource, CustomStringConvertible {
    var description: String
    
    let name: String
    var people: [Person]
    
    mutating func add(_ person: Person) {
        self.people.append(person)
    }
    
    var numberOfRows: Int { people.count }
    var numberOfColumns: Int { 3 }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Name"
        case 1: return "Age"
        case 2: return "Vacation Days"
        default: fatalError("Invalid column")
        }
    }
    
    func getCell(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0: return person.name
        case 1: return "\(person.age)"
        case 2: return "\(person.holidays)"
        default: fatalError("Unknown column")
        }
    }
}

func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    var headerRow = "|"
    var columnWidths = Array<Int>()
    
    for columnIdx in 0...dataSource.numberOfColumns - 1 {
        let columnLabel = dataSource.label(forColumn: columnIdx)
        let columnHeader = "\(columnLabel)|"
        headerRow += columnHeader
        columnWidths.append(columnLabel.count + 10)
    }
    
    print(headerRow)
    
    for rowIndex in 0...dataSource.numberOfRows - 1 {
        var rowOutput = "|"
        
        for columnIndex in 0...dataSource.numberOfColumns - 1 {
            let item = dataSource.getCell(row: rowIndex, column: columnIndex)
            let paddingNeeded = columnWidths[columnIndex] - item.count
            let blankSpaces = repeatElement(" ", count: paddingNeeded).joined()
            
            rowOutput += "\(blankSpaces)\(item)|"
        }
        
        print(rowOutput)
    }
}

var engineeringDept = Department(name: "Engineering", people: [])
engineeringDept.add(Person(name: "Jorge", age: 28, holidays: 12))
engineeringDept.add(Person(name: "Christian", age: 30, holidays: 4))

printTable(engineeringDept)


let operationalDataSource: TabularDataSource = Department(name: "HR", people: [])
//let hrDept = department as Department


let miguel = Person(name: "Miguel", age: 31, holidays: 23)
print(miguel is Person)
