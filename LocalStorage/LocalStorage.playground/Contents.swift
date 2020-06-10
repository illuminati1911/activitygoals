import UIKit
import LocalStorage
import Core
import RxSwift
/// Use this playground as a sandbox to test LocalStorage module features
///

class MockLocalStorage: LocalStorageProtocol {
    private var failing = false

    var goalDB: [Goalable] = []

    init(failing: Bool) {
        self.failing = failing
    }

    func createGoals(goalables: [Goalable]) -> Observable<[Goalable]> {
        goalDB.append(contentsOf: goalables)
        return Observable.from(optional: [
            Goal(id: "1001", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
            Goal(id: "1002", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
            Goal(id: "1003", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100)
        ])
    }

    func fetchGoals() -> Observable<[Goalable]> {
        return Observable.create { [unowned self] observer in
            if self.failing {
                observer.onError(CoreDataProviderError.unknown)
            } else {
                observer.onNext([
                    Goal(id: "1001", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
                    Goal(id: "1002", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100),
                    Goal(id: "1003", title: "GoalFromLocal", description: "Run", type: "steps", goal: 500, trophy: "trophy", points: 100)
                ])
            }
            return Disposables.create()
        }
    }

    func deleteGoals() -> Observable<Void> {
        goalDB = []
        return Observable.from(optional: ())
    }
}

let mock = MockLocalStorage(failing: false)
mock.fetchGoals()
    .subscribe(onNext: { goals in
        print(goals)
    })
