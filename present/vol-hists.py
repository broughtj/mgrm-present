import numpy as np
import matplotlib.pyplot as plt
plt.style.use('seaborn-deep')

#prf = np.loadtxt(fname="oil-profit.csv", delimiter=",")
vol = np.loadtxt(fname="oil-volatility.csv", delimiter=",")


# Volatility Histograms
y = vol[10,:]
x = vol[20,:]

y = np.sqrt(252) * y
x = np.sqrt(252) * x

data = np.vstack([x, y]).T
plt.hist(data, alpha=0.7, label=['1.0', '0.5'])
plt.legend(loc='upper right')
#plt.show()
plt.savefig("oil-volatility-hist.jpg")

