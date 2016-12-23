//
//  main.swift
//  kj
//
//  Created by Fredrik Bixo on 2016-12-20.
//  Copyright © 2016 FredrikBixo. All rights reserved.
//

import Foundation

// Test code

let identityMatrix = IdentityMatrix(rows:3,columns:3)

print("identityMatrix:")
print(identityMatrix.description())


let vector = Vector(dims:2)

vector[1] = 2
vector[2] = 1


let vector2 = Vector(dims:2)
vector2.addConvienceSubscript(mapping: ("x",1))
vector2.addConvienceSubscript(mapping: ("y",2))

vector2["x"] = 1/sqrt(2)
vector2["y"] = 1/sqrt(2)

print("proj:")
print(vector2.projectOnto(vector: vector).description())

let crossProductVector = (vector×vector2)

print("crossProduct:")
print(crossProductVector?.description())
print("dot product: \((vector*vector2)!)")

print(vector2.isUnitVector)

identityMatrix[1,1] = 0
identityMatrix[2,1] = 1
identityMatrix[3,1] = 3
identityMatrix[1,2] = 3
identityMatrix[2,2] = 3
identityMatrix[3,2] = 3
identityMatrix[1,3] = 12
identityMatrix[2,3] = 123
identityMatrix[3,3] = 3
let m = identityMatrix * vector

print("matrixSum:")
print(m?.description())

print(identityMatrix.determinant)
