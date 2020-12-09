import numpy as np


def add(num1, num2):
    return num1 + num2


def avg(arr):
    np_arr = np.array(arr)
    return float(np.mean(np_arr))
