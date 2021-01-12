import numpy as np
import matplotlib.pyplot as plt

data_path = f"..\\Data\\phase_transition_investigation\\max_iter_30000\\"

synch = 8500
max = 6000

file_path = data_path + f"life_data_1_synch{synch}.csv"
data = np.loadtxt(file_path, delimiter=",", skiprows=3, unpack=True, max_rows=30000)
iteration = data[0]
activity = np.absolute(data[5])/100000

plt.plot(iteration[1:max], activity[1:max], "x")
plt.title(f"Start activity variation, synchronicity: {synch}")
plt.xlabel("iteration")
plt.ylabel("activity")
plt.show()
a = 1