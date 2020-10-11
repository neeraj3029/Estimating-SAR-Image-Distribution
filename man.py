import cv2
import numpy as np
import matplotlib.pyplot as plt
from collections import Counter
import csv
img = cv2.imread('patch13.jpg', 0)
# print(Counter(img.ravel()))
c = dict(Counter(img.ravel()))
# for key in c.keys():

#print(c)
fields = ['pixel', 'count']


f = open("pixels.csv", "a")

x = img.ravel()
mean = np.var(img.ravel())
print(mean)
var = 112.86656449711882
# keys = [t for t in c.keys()]
# keys.sort()
# for y in keys:
#     f.write(str(y) + ", " + str(c[y]) + "\n")
# f.close()
# # plt.hist(img.ravel(), bins=256)
# # plt.show();