import UIKit
import RxSwift
import Services
/// Use this playground as a sandbox to test Networking module features
///

let provider = AppProvider.getApplicationProvider()
let disposeBag = DisposeBag()
provider.dataProvider
    .getGoals()
    .subscribe(onNext: { goals in
        print(goals)
    }).disposed(by: disposeBag)
