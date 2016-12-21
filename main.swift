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
vector2.addMapping(mapping: ("x",1))
vector2.addMapping(mapping: ("y",2))

vector2["x"] = 2
vector2["y"] = 3

print("proj:")
print(vector2.projectOnto(vector: vector).description())

let crossProductVector = (vector×vector2)

print("crossProduct:")
print(crossProductVector?.description())
print("dot product: \((vector*vector2)!)")


let m = identityMatrix * vector

print("matrixSum:")
print(m?.description())
