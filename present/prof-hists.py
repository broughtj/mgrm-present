import numpy as np
import matplotlib.pyplot as plt
plt.style.use('seaborn-deep')

prf = np.loadtxt(fname="oil-profit.csv", delimiter=",")

# Profit Histograms
y = prf[10,:]
x = prf[20,:]
y = (((1 + y) ** (365)) - 1) * 100
x = (((1 + x) ** (365)) - 1) * 100

data = np.vstack([x, y]).T
plt.hist(data, alpha=0.7, label=['1.0', '0.5'])
plt.legend(loc='upper right')
#plt.show()
plt.savefig("oil-profit-hist.jpg")


