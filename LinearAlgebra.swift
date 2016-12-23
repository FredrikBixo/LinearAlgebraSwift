
//  Created by Fredrik Bixo on 2016-12-21.
//  Copyright © 2016 FredrikBixo. All rights reserved.
//

import Foundation

infix operator *
infix operator ×
infix operator ≈
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
    
    var determinant:Double {
        return findDeterminant(matrix: self)
    }
    
    private func findDeterminant(matrix:Matrix) -> Double {
        
        var sum:Double = 0.0

        func getMatrix(ignore:Int) -> Matrix {
            
        var matrix2 = Matrix(rows: matrix.rows-1, columns: matrix.columns-1)
            
            var column = 1
            
            for i in 1...matrix.columns {
                if ignore == i {
                    continue
                }
                
                
            for d in 2...matrix.rows {
                matrix2[d-1,column] = matrix[d,i]
            }
                
           column += 1

                
            }

            return matrix2
          
        }
        
        for index in 1...columns {
            
            let matrix3 = getMatrix(ignore:index)
            
            if matrix3.columns == 2 {
            sum += (pow(-1, 1+Double(index)) * matrix[1,index]) * ((matrix3[1,1]*matrix3[2,2]) - (matrix3[1,2]*matrix3[2,1]))
            } else {
            sum += (pow(-1, 1+Double(index)) * matrix[1,index]) * findDeterminant(matrix: matrix3)
            }
            
        }
    

        
        return sum
    }
    
    fileprivate var array: [[Double]]
    
    init(rows:Int, columns:Int) {
        array =  Array(repeating: Array(repeating: 0, count: columns), count: rows)
    }
    
    convenience init(dimension:Int) {
        self.init(rows:dimension,columns:dimension)
    }
    
    convenience init() {
        self.init(rows:3,columns:3)
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
    
    static func ≈ (left: Double, right: Double) -> Bool {
        
        // throws maybe
        
        return Float(left) == Float(right)
    }

    
}

class Vector {
    
    var dims:Int {
        return array.count
    }
    
    var isUnitVector:Bool {
        
        var sum:Double = 0
        
        for row in 1...self.dims {
             sum += pow(self[row], 2)
        }
    
        print(sqrt(sum))
        
        return sqrt(sum) ≈ 1.0
    }
    
    private var array: [Double]
    
    private var mappings = ["x":1,"y":2,"z":3]
    
    init(dims:Int) {
        array =  Array(repeating: 0, count: dims)
    }
    
    public func addConvienceSubscript(mapping:(String,Int)) {
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
