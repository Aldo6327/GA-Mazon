import UIKit
import PassKit

class ApplePayViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    var paymentRequest: PKPaymentRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func itemToSell(shipping: Double) -> [PKPaymentSummaryItem] {
        let item = PKPaymentSummaryItem(label: "Sub-Total", amount: 1010.00)
        let tax = PKPaymentSummaryItem(label: "Tax", amount: 90.00)
        let shipping = PKPaymentSummaryItem(label: "Shipping", amount: NSDecimalNumber(string: "\(shipping)"))
        let totalAmount = item.amount.adding(tax.amount)
        let totalPrice = PKPaymentSummaryItem(label: "Dragon Scales", amount: totalAmount)
        return [item, shipping, tax, totalPrice]
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        completion(PKPaymentAuthorizationStatus.success, itemToSell(shipping: Double(shippingMethod.amount)))
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        completion(PKPaymentAuthorizationStatus.success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applePay(_ sender: Any) {
        
        let paymentNetworks = [PKPaymentNetwork.amex, .visa, .masterCard]
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            paymentRequest = PKPaymentRequest()
            paymentRequest.currencyCode = "USD"
            paymentRequest.countryCode = "US"
            paymentRequest.merchantIdentifier = "merchant.com.general-assembly.GA-mazon"
            paymentRequest.supportedNetworks = paymentNetworks
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.requiredShippingContactFields = []
            paymentRequest.paymentSummaryItems = self.itemToSell(shipping: 20.00)
            
            let sameDayShipping = PKShippingMethod(label: "Same Day Delivery", amount: 14.99)
            sameDayShipping.detail = "Delivery on same day"
            sameDayShipping.identifier = "sameDay"
            
            paymentRequest.shippingMethods = [sameDayShipping]
            
            let applePayVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            applePayVC?.delegate = self
            self.present(applePayVC!, animated: true, completion: nil)
            
            
        } else {
            print("Tell the user to set up Apple Pay.")
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

