import numpy as np
import matplotlib.pyplot as plt

data_path = f"..\\Data\\phase_transition_investigation\\"

file_path = data_path + f"life_data_steady_state_investigation.csv"
data = np.loadtxt(file_path, delimiter=",", skiprows=3, unpack=True)
iteration = data[0]
activity = np.absolute(data[5])/100000

def plot_step_averaged_activity(step):
    avg_activity = []
    stepped_iteration = []
    step = step
    for i in range(step+1, len(activity), step):
        avg_activity.append(activity[i - step:i].sum()/step)
        stepped_iteration.append(iteration[i])

    plt.plot(stepped_iteration[1:], avg_activity[1:], "x")
    plt.title(f"Avg activity per {step} steps")
    plt.plot()
    plt.xlabel("iteration")
    plt.ylabel(f"{step} step averaged activity")
    plt.grid()
    plt.show()



plt.plot(iteration[1:], activity[1:], "x")
plt.title("Total activity / iteration plot")
plt.grid()
plt.xlabel("iteration")
plt.ylabel("activity")
plt.show()

plt.plot(iteration[1:100], activity[1:100], "x")
plt.title("Start activity variation")
plt.xlabel("iteration")
plt.ylabel("activity")
plt.show()

step_list = [2, 5, 10, 20, 50, 100, 1000, 10000]
for step in step_list:
    plot_step_averaged_activity(step)

a = 1