import numpy as np
import matplotlib.pyplot as plt

max_iterations = 30000
use_last = 1000 #uses last n iterations

min_synch = 10
max_synch = 90

data_path = f"..\\Data\\phase_transition_investigation\\max_iter_{max_iterations}\\"

repetitions = 1

avg_activity_list = []
synchronicity_list = [1000,2000,3000,4000,5000,6000,7000,8000,8500,8600,8700,8800,8900,9000,9100,9125,9150,9155,9158,9162,9165,9168,9170,9172,9175,9200,9225,9250,9275,9300,9325,9350,9375,9400,9500,9800,10000]
activity_errors = []
repetitions_total = 0

for synchronicity in synchronicity_list:
    for i in range(1, repetitions+1):
        file_path = data_path + f"life_data_{i}_synch{synchronicity}.csv"
        data = np.loadtxt(file_path, delimiter=",", skiprows=3, unpack=True, max_rows= max_iterations)
        activity_data = np.absolute(data[5])/100000
        sum_array = activity_data[max_iterations - use_last:]
        avg_activity = sum_array.sum()/use_last #average of activities between specified indexes (to get avg steady state activity)
        repetitions_total += avg_activity

    #synchronicity_list.append(synchronicity)
    avg_activity_list.append(repetitions_total / repetitions)  # adds average of repetitions to avgerage activity array
    repetitions_total = 0  # variable for tracking total activities accross repititions

for i in range(len(synchronicity_list)):
    synchronicity_list[i] = synchronicity_list[i] / 100
    activity_errors.append(0.00001)

#plt.plot(synchronicity_list, avg_activity_list, "x")
plt.errorbar(synchronicity_list, avg_activity_list, yerr=activity_errors, lolims=False, fmt = "x")
plt.grid()
plt.xlabel("Synchronicity %")
plt.ylabel("Average steady state activity")
plt.show()
a = 1