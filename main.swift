
func apartmentHunting(_ blocks: [[String: Bool]], _ requirements: [String]) -> Int {
  var minDistance = Int.max
  var nearestApartment = -1
  var visited: Set<Int> = []
  
  func getNeighbors(_ root: Int) -> [Int] {
    var neighbors: [Int] = []
    // left
    if root - 1 >= 0 {
      neighbors.append(root - 1)
    }
    // right
    if root + 1 < blocks.count {
      neighbors.append(root + 1)
    }
    return neighbors
  }
  
  func bfs(_ root: Int) {
    var level = 0
    var localReqs: [String: Bool] = [:]
    var queue: [Int] = []
    queue.append(root)
    visited.insert(root)
    // Init local reqs
    requirements.forEach {
      localReqs[$0] = false
    }
    // Init local reqs from root
    blocks[root].forEach {
      if $0.1 == true {
        localReqs[$0.0] = $0.1
      }
    }
    while queue.count > 0 {
      // Check if all reqs are met
      if !localReqs.values.contains(false) {
        if level < minDistance {
          minDistance = level
          nearestApartment = root
        }
      }
      level += 1
      let qCount = queue.count
      for _ in 0..<qCount {
        let node = queue.removeFirst()
        for neighbor in getNeighbors(node) {
          if !visited.contains(neighbor) {
            queue.append(neighbor)
            visited.insert(neighbor)
            // Adjust localReqs
            blocks[neighbor].forEach {
              if $0.1 == true {
                localReqs[$0.0] = $0.1
              }
            }
          }
        }
      }
    }
  }

  for i in blocks.indices {
    visited = []
    bfs(i)
  }

  return nearestApartment
}



let blocks = [
  [
    "gym": false,
    "school": true,
    "store": false
  ],
  [
    "gym": true,
    "school": false,
    "store": false
  ],
  [
    "gym": true,
    "school": true,
    "store": false
  ],
  [
    "gym": false,
    "school": true,
    "store": false
  ],
  [
    "gym": false,
    "school": true,
    "store": true
  ]
]

let reqs = ["gym", "school", "store"]

let result = apartmentHunting(blocks, reqs)

print(result)