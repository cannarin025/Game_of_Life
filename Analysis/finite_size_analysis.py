import numpy as np
import matplotlib.pyplot as plt

max_iterations = 30000
use_last = 1000 #uses last n iterations

data_path = f"..\\Data\\finite_size_investigation\\max_iter_{max_iterations}\\"

size = 32

repetitions = 1

avg_activity_list = []
rep_list = []

for i in range(1, repetitions+1):
    file_path = data_path + f"life_data_{i}_size{size}.csv"
    data = np.loadtxt(file_path, delimiter=",", skiprows=3, unpack=True, max_rows= max_iterations)
    activity_data = np.absolute(data[5])/100000
    sum_array = activity_data[max_iterations - use_last:]
    avg_activity = sum_array.sum()/use_last #average of activities between specified indexes (to get avg steady state activity)

    #synchronicity_list.append(synchronicity)
    rep_list.append(i)
    avg_activity_list.append(avg_activity)  # adds average of repetitions to avgerage activity array


plt.plot(rep_list, avg_activity_list)
plt.grid()
plt.xlabel("Repetition no")
plt.ylabel("Average steady state activity")
plt.show()
a = 1