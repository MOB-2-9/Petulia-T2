import UIKit

var greeting = "Hello, playground"

print(greeting.count)

var count = 0
for char in greeting {
    count += 1
}
print(count)

//3 synchronous tasks
//func task1(@escaping callback: (Bool?, String?) -> Void) {
//    sleep(2)
//    callback(true, nil)
//}
//
//func task2(@escaping callback: (Bool?, String?) -> Void) {
//    sleep(2)
//}
//
//func task3(@escaping callback: (Bool?, String?) -> Void) {
//    sleep(2)
//}
//
//task1 { isSuccess, error in
//    if let error = error {
//        print("\(error)")
//        return
//    }
//}
//
//task2 { isSuccess, error in
//    if let error = error {
//        print("\(error)")
//        return
//    }
//}
//
//task3 { isSuccess, error in
//    if let error = error {
//        print("\(error)")
//        return
//    }
//    DispatchQueue.main.async {
//
//    }
//}

/*
 /**
  * Definition for singly-linked list.
  * struct ListNode {
  *     int val;
  *     ListNode *next;
  *     ListNode() : val(0), next(nullptr) {}
  *     ListNode(int x) : val(x), next(nullptr) {}
  *     ListNode(int x, ListNode *next) : val(x), next(next) {}
  * };
  */
 class Solution {
 public:
     ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
     }
 };
 */



public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() {
        self.val = 0;
        self.next = nil
    }
    public init(_ val: Int) {
        self.val = val;
        self.next = nil
    }
    
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val;
        self.next = next
    }
}

//
var tail1 = ListNode(30)
var body1 = ListNode(20, tail1)
var head1 = ListNode(10, body1)

var tail2 = ListNode(25)
var body2 = ListNode(2, tail2)
var head2 = ListNode(1, body2)

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var list1 = l1
    var list2 = l2
    
    let head: ListNode = ListNode(0)
    var tmp = head
    while list1 != nil && list2 != nil {
        let v1 = list1!.val
        let v2 = list2!.val
        
        if v1 > v2 {
            tmp.next = list2!
            list2 = list2?.next
        } else {
            tmp.next = list1!
            list1 = list1?.next
        }
        tmp = tmp.next!
    }
    tmp.next = list1 ?? list2
    return head.next
//    guard let l1 = l1 else { return l2 }
//    guard let l2 = l2 else { return l1 }
//    var resultNode: ListNode?
//    var curr1: ListNode?
//    var curr2: ListNode?
//    //compare l1 value, with l2 value
//    if l1.val < l2.val {
//        resultNode = l1
//        curr1 = resultNode?.next
//        curr2 = l2
//    } else {
//        resultNode = l2
//        curr2 = resultNode?.next
//        curr1 = l1
//    }
//    while resultNode?.next != nil {
//        guard let curr1 = curr1 else {
//            resultNode?.next = curr2
//            break
//        }
//        guard let curr2 = curr2 else {
//            resultNode?.next = curr1
//            break
//        }
//        if curr1.val < curr2.val {
//            resultNode?.next = curr1
//            resultNode = resultNode?.next
//            curr1 =
//        } else {
//            resultNode?.next = curr2
//            resultNode = resultNode?.next
//        }
//    }
//    return resultNode
}

mergeTwoLists(head1, head2)
