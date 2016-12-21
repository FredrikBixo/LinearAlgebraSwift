
//
//  Created by Fredrik Bixo on 2016-12-20.
//  Copyright © 2016 FredrikBixo. All rights reserved.
//

import Foundation

infix operator *
infix operator ×

// MARK: Matrix Operators

extension Matrix {
    static func * (left: Matrix, right: Matrix) -> Matrix? {
        
        // throws maybe
        
        if left.columns != right.rows {
            return nil
        }
        
        let m = Matrix(rows:left.rows,columns:right.columns)
        
        for row in 1...left.rows {
            for column in 1...right.columns {
                var sum:Double = 0
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
            var sum:Double = 0
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
    
    var determinant:Int {
        return 0
    }
    
    fileprivate var array: [[Double]]
    
    init(rows:Int, columns:Int) {
        
        array =  Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
    }
    
    subscript(row:Int, column:Int) -> Double {
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

class IdentityMatrix:Matrix {
    
    override init(rows:Int, columns:Int) {
        super.init(rows:rows,columns:columns)
        array =  Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
        for i in 1...self.columns {
            self[i,i] = 1
        }
    }
    
    
}

// MARK: Vector Operators

extension Vector {
    static func * (left: Vector, right: Vector) -> Double? {
        
        // throws maybe
        
        if left.dims != right.dims {
            return nil
        }
        
        var sum:Double = 0.0
        
        for row in 1...left.dims {
            sum += left[row]*right[row]
        }
        
        return sum
    }
    
    static func × (left: Vector, right: Vector) -> Vector? {
        
        // throws maybe
        
        if !(left.dims == 3 && right.dims == 3) {
            return nil
        }
        
        let m = Vector(dims:right.dims)
        
        
        m[1] = (left[2]*right[3]) - (left[3]*right[2])
        m[2] = (left[3]*right[1]) - (left[1]*right[3])
        m[3] = (left[1]*right[2]) - (left[2]*right[1])

        return m
    }
    
}

// MARK: Double Operators

extension Double {
    static func * (left: Double, right: Vector) -> Vector {
        
        // throws maybe
        
        let m = Vector(dims:right.dims)

        for row in 1...right.dims {
            m[row] = left*right[row]
        }
        
        return m
    }

}

class Vector {
    
    var dims:Int {
        return array.count
    }
    
    private var array: [Double]
    
    private var mappings = [String:Int]()
    
    init(dims:Int) {
        
        array =  Array(repeating: 0, count: dims)
    }
    
    public func addMapping(mapping:(String,Int)) {
        mappings[mapping.0] = mapping.1
    }
    
    public func projectOnto(vector:Vector) -> Vector {
        
        let c = ((self*vector)!/(vector*vector)!)
        
        return c*vector
    }
    
    subscript(row:Int) -> Double {
        get {
            return array[row-1]
        }
        set(newValue) {
            array[row-1] = newValue
        }
    }
    
    subscript(row:String) -> Double {
        get {
            if let m = mappings[row] {
            return array[m-1]
            }
            return 0
        }
        set(newValue) {
            if let m = mappings[row] {
            array[m-1] = newValue
            }
        }
    }
    
    public func description() {
        print(array)
    }
    
}
