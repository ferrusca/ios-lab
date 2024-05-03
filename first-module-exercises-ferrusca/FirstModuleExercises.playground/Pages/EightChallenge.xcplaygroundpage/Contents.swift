import Foundation
import XCTest


class PrimeCalculator {
    static func calculate(upTo limit: Int) -> [Int] {
        var primeNumbers = Array<Int>()
        
        for currentNumber in 2...limit {
            if(currentNumber == 2) {
                primeNumbers.append(currentNumber)
                continue
            }
            
            var isPrime = true
            
            for divisor in 2...currentNumber/2+1  {
                if currentNumber % divisor == 0 {
                    isPrime = false
                    break
                }
            }
            
            let alreadyExistent = primeNumbers.contains{ val in val % currentNumber == 0 }
            if (isPrime && !alreadyExistent) {
                primeNumbers.append(currentNumber)
            }
        }
        
        return primeNumbers
    }
}


class SieveTest: XCTestCase {

    func testPrimes() {
        // given
        let firstTestInput = 10
        let secondTestInput = 50
        let thirdTestInput = 85

        // when
        let firstPrimeNumbers = PrimeCalculator.calculate(upTo: firstTestInput)
        let secondPrimeNumbers = PrimeCalculator.calculate(upTo: secondTestInput)
        let thirdPrimeNumbers = PrimeCalculator.calculate(upTo: thirdTestInput)

        // then
        XCTAssertEqual(firstPrimeNumbers.count, 4)
        XCTAssertEqual(secondPrimeNumbers.count, 15)
        XCTAssertEqual(thirdPrimeNumbers.count, 23)
    }
}

SieveTest.defaultTestSuite.run()
