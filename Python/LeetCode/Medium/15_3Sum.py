"""

Code
Code
Code Sample
Testcase
Testcase
Test Result
15. 3Sum
Solved
Medium
Topics
premium lock icon
Companies
Hint
Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

Notice that the solution set must not contain duplicate triplets.

 

Example 1:

Input: nums = [-1,0,1,2,-1,-4]
Output: [[-1,-1,2],[-1,0,1]]
Explanation: 
nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
The distinct triplets are [-1,0,1] and [-1,-1,2].
Notice that the order of the output and the order of the triplets does not matter.
Example 2:

Input: nums = [0,1,1]
Output: []
Explanation: The only possible triplet does not sum up to 0.
Example 3:

Input: nums = [0,0,0]
Output: [[0,0,0]]
Explanation: The only possible triplet sums up to 0.
"""

# Top1
from collections import Counter
from bisect import bisect_left, bisect_right
from typing import List


class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        n = len(nums)

        if n < 3:
            return []

        # Counter construction costs more than a direct check.
        if n == 3:
            return [nums] if nums[0] + nums[1] + nums[2] == 0 else []

        # For small inputs, the simpler O(n²) algorithm wins
        # because it has very little setup overhead.
        if n < 20:
            nums.sort()
            result = []

            for i in range(n - 2):
                first = nums[i]

                if first > 0:
                    break

                if i and first == nums[i - 1]:
                    continue

                left = i + 1
                right = n - 1

                while left < right:
                    total = first + nums[left] + nums[right]

                    if total < 0:
                        left += 1

                    elif total > 0:
                        right -= 1

                    else:
                        result.append([
                            first,
                            nums[left],
                            nums[right]
                        ])

                        left_value = nums[left]
                        right_value = nums[right]

                        left += 1
                        right -= 1

                        while (
                            left < right
                            and nums[left] == left_value
                        ):
                            left += 1

                        while (
                            left < right
                            and nums[right] == right_value
                        ):
                            right -= 1

            return result

        counts = Counter(nums)
        zero_count = counts.pop(0, 0)

        result = []
        append = result.append

        if zero_count >= 3:
            append([0, 0, 0])

        if not counts:
            return result

        unique = sorted(counts)
        counts_set = set(unique)

        # Handle answers containing zero or a repeated number.
        for num in unique:
            if (
                num < 0
                and zero_count
                and -num in counts_set
            ):
                append([num, 0, -num])

            if not num & 1:
                candidate = -(num >> 1)

                if (
                    candidate in counts_set
                    and counts[candidate] >= 2
                ):
                    if num < candidate:
                        append([num, candidate, candidate])
                    else:
                        append([candidate, candidate, num])

        if len(unique) < 2:
            return result

        first_unique = unique[0]
        last_unique = unique[-1]

        a = -last_unique // 2
        start = bisect_right(
            unique,
            a if a > first_unique else first_unique
        )

        a = -(first_unique // 2)
        stop = bisect_left(
            unique,
            a if a < last_unique else last_unique
        )

        # Batch construction pays off only when there are enough
        # unique values spread sparsely across a large range.
        use_batching = (
            len(unique) > 100
            and last_unique - first_unique + 1 > len(unique) * 4
        )

        if use_batching:
            for i in range(start, stop):
                middle = unique[i]

                right_start = (
                    bisect_right(unique, middle * -2)
                    if middle < 0
                    else i + 1
                )

                right_stop = bisect_right(
                    unique,
                    -first_unique - middle
                )

                target = -middle

                result.extend([
                    [target - right, middle, right]
                    for right in unique[right_start:right_stop]
                    if target - right in counts_set
                ])

        else:
            for i in range(start, stop):
                middle = unique[i]

                right_start = (
                    bisect_right(unique, middle * -2)
                    if middle < 0
                    else i + 1
                )

                right_stop = bisect_right(
                    unique,
                    -first_unique - middle
                )

                for right in unique[right_start:right_stop]:
                    left = -middle - right

                    if left in counts_set:
                        append([left, middle, right])

        return result

#############################################################################################

# Top 2
from bisect import bisect_left, bisect_right
class Solution:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        counts = Counter(nums)
        ans = []
        # I only use zeros in 2 places
        zeros = counts.pop(0,0)
        append = ans.append
        # x == y == z
        if zeros >= 3:
            append([0,0,0])
        if not counts:
            return ans
        unique = sorted(counts)
        n = len(unique)
        if n < 2:
            return ans
        counts_set = set(unique)
        for num in unique:
            # x != 0
            # x < 0, y == 0, z > 0
            if num < 0 < zeros and -num in counts_set:
                append([num, 0, -num])
            
            # Even x, even y+z
            if not (num & 1):
                # y == z
                # x + y + z = x + 2y = x + -x = 0
                complement = -(num>>1)
                # Cover duplicates
                if complement in counts_set and counts[complement] >= 2:
                    append([num, complement, complement])
        # Still need to cover x < y < 0 < z and x < 0 < y < z
        # Only need unique for this part
        # x < 0 from now on
        divide = bisect_left(unique, 0)
        if not (divide and divide - n and n > 2):
            return ans
        

        # second_smallest_neg = unique[1] if divide >= 2 else 0
        # second_largest_neg = unique[divide-2] if divide >= 2 else 0
        # second_smallest_pos = unique[divide+1] if n-divide >= 2 else 0
        # second_largest_pos = unique[-2] if n-divide >= 2 else 0
        
        # min_x <= x <= max_x < 0 < min_z <= z <= max_z
        # min_x <= x < y < z <= max_z
        # y = -(x+z)
        # min_x <= x < -(x+z) < z <= max_z
        # (min_x+x)/2 <= x < -z/2 < (z+x)/2 <= (max_z+x)/2
        # -(max_z+x)/2 <= -(z+x)/2 < z/2 < -x <= -(min_x+x)/2
        # (min_x+z)/2 <= (x+z)/2 < -x/2 < z <= (max_z+z)/2
        
        # No more negative or positive concerns for y
        # Just make y the one that gets calculated
        # Fewer positives
        if divide << 1 < n:
            lo_i = bisect_left(unique, 1-(unique[-1]<<1), 0, divide)
            hi_i = bisect_right(unique, (-unique[divide]-1)>>1, lo_i, divide)
            lo_k = n
            hi_k = n
            for x in unique[lo_i:hi_i]:
                lo_k = bisect_left(unique,(2-x)>>1, divide, lo_k)
                hi_k = bisect_right(unique, -1-(x<<1), lo_k, hi_k)
                for z in unique[lo_k:hi_k]:
                    y = -(x+z)
                    if y in counts_set:
                        append([x,y,z])
        # Fewer negatives
        else:
            lo_k = bisect_left(unique, (2-unique[divide-1])>>1, divide, n)
            hi_k = bisect_right(unique, -1-(unique[0]<<1), lo_k, n)
            lo_i = divide
            hi_i = divide
            for z in unique[lo_k:hi_k]:
                lo_i = bisect_left(unique, 1-(z<<1), 0, divide)
                hi_i = bisect_right(unique, (-z-1)>>1, lo_i, divide)
                for x in unique[lo_i:hi_i]:
                    y = -(x+z)
                    if y in counts_set:
                        append([x,y,z])             

        return ans

# Mine failed due to overtime
from itertools import combinations

class Solution:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        ans=[]
        for i, j, k in combinations(range(len(nums)), 3):
            cmb=sorted([nums[i] ,nums[j] ,nums[k]])
            if nums[i] + nums[j] + nums[k] == 0 and cmb not in ans:
                
                ans.append(cmb)
        return ans

        