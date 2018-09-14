import UIKit
import SwipeMenuViewController

final class ViewController: SwipeMenuViewController {
    
    private var datas: [String] = ["Bulbasaur","Caterpie", "Golem", "Jynx", "Marshtomp", "Salamence", "Riolu", "Araquanid"]
    private var imgs: [String] = ["ic_navid_tab_zzim_n","ic_navid_tab_recent_n","ic_navid_tab_alram_n",
                                  "ic_navid_tab_zzim_n","ic_navid_tab_recent_n","ic_navid_tab_alram_n",
                                  "ic_navid_tab_zzim_n","ic_navid_tab_recent_n","ic_navid_tab_alram_n"]
    private var selectedImgs: [String] = ["ic_navid_tab_zzim_s","ic_navid_tab_recent_s","ic_navid_tab_alram_s",
                                          "ic_navid_tab_zzim_s","ic_navid_tab_recent_s","ic_navid_tab_alram_s",
                                          "ic_navid_tab_zzim_s","ic_navid_tab_recent_s","ic_navid_tab_alram_s"]
    var dataCount: Int = 8
    @IBOutlet private weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        
        datas.forEach { data in
            let vc = ContentViewController()
            vc.title = data
            vc.content = data
            self.addChildViewController(vc)
        }
        //        options.tabView.margin = 60;
        //        options.tabView.clipsToBounds = true
        options.tabView.trailing = -60
        options.tabView.backgroundColor = .black
        options.tabView.itemView.selectedTextColor = .white
        
        super.viewDidLoad()
        
        view.bringSubview(toFront: settingButton)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popupSegue" {
            let vc = segue.destination as! PopupViewController
            vc.options = options
            vc.dataCount = dataCount
            vc.reloadClosure = { self.reload() }
        }
    }
    
    private func reload() {
        swipeMenuView.reloadData(options: options)
    }
    
    // MARK: - SwipeMenuViewDelegate
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewWillSetupAt: currentIndex)
        print("will setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewDidSetupAt: currentIndex)
        print("did setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, willChangeIndexFrom: fromIndex, to: toIndex)
        print("will change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, didChangeIndexFrom: fromIndex, to: toIndex)
        print("did change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    
    // MARK - SwipeMenuViewDataSource
    
    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return dataCount
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return childViewControllers[index].title ?? ""
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, imagesForItemAt index: Int) -> (UIImage?, UIImage?)? {
        return (UIImage(named: imgs[index]), UIImage(named: selectedImgs[index]))
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, positionForImageAt index: Int) -> TitleImagePosition {
        return index % 2 == 0 ? .left : .right
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = childViewControllers[index]
        vc.didMove(toParentViewController: self)
        return vc
    }
}
