require_relative 'bst'

bst = Tree.new(Array.new(15) { rand(1..100) })

bst.pretty_print

p bst.balanced?

p bst.level_order
p bst.inorder
p bst.preorder
p bst.postorder

bst.insert(83)
bst.insert(11)
bst.insert(37)
bst.insert(58)

bst.pretty_print
p bst.balanced?

bst.rebalance

bst.pretty_print
p bst.balanced?

p bst.level_order
p bst.inorder
p bst.preorder
p bst.postorder