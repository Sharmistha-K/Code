# -*- coding: utf-8 -*-
"""
Created on Sat Oct 23 18:32:36 2021

@author: Sharmistha
"""

def fib(n,d = {}):
    if str(n) in d.keys():
        return d[str(n)]
    elif n<=2 :
        return 1
    else:
        d[str(n)]= fib(n-1, d) + fib(n-2,d)
    return d[str(n)]
print(fib(50))
