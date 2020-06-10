import UIKit
import Core
/// Use this playground as a sandbox to test Core module features
///

func getGoal() -> Goal {
    return Goal(
        id: "1000",
        title: "Easy walk steps",
        description: "Walk 500 steps a day",
        type: "step",
        goal: 500,
        trophy: "bronze_medal",
        points: 6
    )
}

print(getGoal().title)
