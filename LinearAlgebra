import Foundation

infix operator *
extension Matrix {
    static func * (left: Matrix, right: Matrix) -> Matrix? {
        
        // throws maybe
        
        if left.columns != right.rows {
            return nil
        }
        
        let m = Matrix(rows:left.rows,columns:right.columns)
        
        for row in 1...left.rows {
            for column in 1...right.columns {
                var sum = 0
                for row2 in 1...right.rows {
                    sum += left[row,row2] * right[row2,column]
                }
                m[row,column] = sum
            }
        }
        
        return m
    }
    
    static func * (left: Matrix, right: Vector) -> Vector? {
        
        // throws maybe
        
        if left.columns != right.dims {
            return nil
        }
        
        let m = Vector(dims:right.dims)
        
        for row in 1...left.rows {
            var sum = 0
            for row2 in 1...right.dims {
                sum += left[row,row2] * right[row2]
            }
            m[row] = sum
        }
        
        return m
    }
    
}

class Matrix {
    
    var rows:Int {
        return array.count
    }
    
    var columns:Int {
        return array[0].count
    }
    
    private var array: [[Int]]
    
    init(rows:Int, columns:Int) {
        
        array =  Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
    }
    
    subscript(row:Int, column:Int) -> Int {
        get {
            return array[row-1][column-1]
        }
        set(newValue) {
            array[row-1][column-1] = newValue
        }
    }
    
    public func description() {
        print(array)
    }
    
}

class Vector {
    
    var dims:Int {
        return array.count
    }
    
    private var array: [Int]
    
    private var mappings = [String:Int]()
    
    init(dims:Int) {
        
        array =  Array(repeating: 0, count: dims)
    }
    
    public func addMapping(mapping:(String,Int)) {
        mappings[mapping.0] = mapping.1
    }
    
    subscript(row:Int) -> Int {
        get {
            return array[row-1]
        }
        set(newValue) {
            array[row-1] = newValue
        }
    }
    
    subscript(row:String) -> Int {
        get {
            if let m = mappings[row] {
            return array[m]
            }
            return 0
        }
        set(newValue) {
            if let m = mappings[row] {
            array[m] = newValue
            }
        }
    }
    
    public func description() {
        print(array)
    }
    
}
