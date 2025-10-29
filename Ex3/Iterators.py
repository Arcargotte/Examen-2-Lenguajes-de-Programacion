class MergeNode:
    def __init__(self, left=None, right=None, value=None):
        self.left = left
        self.right = right
        self.value = value 

        if self.is_leaf():
            self.min_left = None
            self.min_right = None
        else:
            self.min_left = left.peek() if left else None
            self.min_right = right.peek() if right else None

    def is_leaf(self):

        return self.value is not None

    def peek(self):

        if self.is_leaf():
            return self.value
        
        if self.min_left is None:
            return self.min_right
        
        if self.min_right is None:
            return self.min_left
        
        return min(self.min_left, self.min_right)

    def pop(self):

        if self.is_leaf():
            v = self.value
            self.value = None
            self.min_left = None
            return v

        if self.min_right is None or (
            self.min_left is not None and self.min_left <= self.min_right
        ):
            v = self.left.pop()
            self.min_left = self.left.peek()
        else:
            v = self.right.pop()
            self.min_right = self.right.peek()

        return v
    
def build_tree(lst):

    if len(lst) == 1:
        return MergeNode(value=lst[0])
    
    mid = len(lst) // 2

    return MergeNode(build_tree(lst[:mid]), build_tree(lst[mid:]))

class MergeSortIterator:

    def __init__(self, data):
        self.root = build_tree(data) 

    def __iter__(self):
        return self 

    def __next__(self):

        if self.root.peek() is None:
            raise StopIteration
        
        v = self.root.peek()
        self.root.pop()

        return v

data = [1, 3, 3, 2, 1, 234, 32, 0]
ite = MergeSortIterator(data)

for x in ite:
    print(x)