import Foundation

protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }

    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}

func getLongestItemCount(_ dataSource: TabularDataSource, _ columnIndex: Int, currentMax: Int) -> Int {
    var max = currentMax;

    for rowIndex in 0...dataSource.numberOfRows - 1 {
        let item = dataSource.itemFor(row: rowIndex, column: columnIndex)
        max = item.count > max ? item.count : max
    }

    return max
}

func getLabelFormatted(label: String, offsetRequired: Int) -> String {
    let paddingNeeded = offsetRequired - label.count
    let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
    return "\(padding) \(label) |"
}

func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print(dataSource)
    var headerRow = "|"
    var columnWidths = [Int]()

    for columnIndex in 0..<dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: columnIndex)
        columnWidths.append(getLongestItemCount(dataSource, columnIndex, currentMax: columnLabel.count))

        headerRow += getLabelFormatted(label: columnLabel, offsetRequired: columnWidths[columnIndex])
    }

    print(headerRow)

    for rowIndex in 0..<dataSource.numberOfRows {
        // Start the output string
        var output = "|"

        // Append each item in this row to the string
        for rowColumnIndex in 0..<dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: rowIndex, column: rowColumnIndex)
            output += getLabelFormatted(label: item, offsetRequired: columnWidths[rowColumnIndex])
        }

        // Done - print it!
        print(output)
    }
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department: TabularDataSource {
    let name: String
    var people: [Person] = []

    init(name: String) {
        self.name = name
    }

    mutating func add(_ person: Person) {
        people.append(person)
    }

    var numberOfRows: Int { people.count }

    var numberOfColumns: Int { 3 }

    func label(forColumn column: Int) -> String {
        let label: String

        switch column {
        case 0: label = "Employee name"
        case 1: label = "Age"
        case 2: label = "Years of experience"
        default: fatalError("Invalid column!")
        }

        return label
    }

    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]

        let item: String
        switch column {
        case 0: item = person.name
        case 1: item = String(person.age)
        case 2: item = String(person.yearsOfExperience)
        default: fatalError("Invalid column!")
        }

        return item
    }
}

// Mark - Conforming CustomStringConvertible
extension Department: CustomStringConvertible {
    var description: String { "Department: \(name)" }
}

var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh Saleh Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50912021902192102, yearsOfExperience: 20))

printTable(department)

struct Book {
    let title: String
    let author: String
    let averageReview: Int
}


struct BookColection: TabularDataSource, CustomStringConvertible {
    let name: String
    var books: [Book] = []

    init(name: String) {
        self.name = name
    }

    mutating func add(_ book: Book) {
        books.append(book)
    }

    var numberOfRows: Int { books.count }

    var numberOfColumns: Int { 3 }

    func label(forColumn column: Int) -> String {
        let label: String

        switch column {
        case 0: label = "Title"
        case 1: label = "Author"
        case 2: label = "Average Review"
        default: fatalError("Invalid column!")
        }

        return label
    }

    func itemFor(row: Int, column: Int) -> String {
        let book = books[row]

        let item: String
        switch column {
        case 0: item = book.title
        case 1: item = String(book.author)
        case 2: item = String(book.averageReview)
        default: fatalError("Invalid column!")
        }

        return item
    }

    var description: String { "Book collection: \(name)" }
}

print("\n-------\n")
var books = BookColection(name: "\"Best collection ever\"")
books.add(Book(title: "100 anios de soledad", author: "Gabriel Garcia Márquez", averageReview: 8))
books.add(Book(title: "Pedro Paramo", author: "Juan Rulfo", averageReview: 9))
books.add(Book(title: "El rey Lear", author: "William Shakespeare", averageReview: 99288))

printTable(books)
