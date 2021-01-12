import numpy as np
import matplotlib.pyplot as plt

max_iterations = 30000
use_last = 1000 #uses last n iterations

min_synch = 10
max_synch = 90

data_path = f"..\\Data\\max_iter_{max_iterations}\\"

repetitions = 1

avg_activity_list = []
synchronicity_list = []
repetitions_total = 0

for synchronicity in range(min_synch, max_synch + 1, 10):
    for i in range(1, repetitions+1):
        file_path = data_path + f"life_data_{i}_synch{synchronicity}.csv"
        data = np.loadtxt(file_path, delimiter=",", skiprows=3, unpack=True, max_rows= max_iterations)
        activity_data = np.absolute(data[5])/100000
        sum_array = activity_data[max_iterations - use_last:]
        avg_activity = sum_array.sum()/use_last #average of activities between specified indexes (to get avg steady state activity)
        repetitions_total += avg_activity

    synchronicity_list.append(synchronicity)
    avg_activity_list.append(repetitions_total / repetitions)  # adds average of repetitions to avgerage activity array
    repetitions_total = 0  # variable for tracking total activities accross repititions


plt.plot(synchronicity_list, avg_activity_list)
plt.grid()
plt.xlabel("Synchronicity %")
plt.ylabel("Average steady state activity")
plt.show()
a = 1