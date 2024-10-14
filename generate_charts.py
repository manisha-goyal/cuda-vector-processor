import pandas as pd
import matplotlib.pyplot as plt

# Read the experiment results from the CSV file
data = pd.read_csv('experiment_results.csv')

# Separate the data into experiment 1 and experiment 2
exp1_data = data[data['experiment'] == 'experiment1']
exp2_data = data[data['experiment'] == 'experiment2']

# Plot for Experiment 1 (CPU vs GPU times for varying configurations)
plt.figure(figsize=(12, 6))
configurations = exp1_data.apply(lambda row: f"{row['blocks']}, {row['threads']}", axis=1)
cpu_times = exp1_data['cpu_time']
gpu_times = exp1_data['gpu_time']

# Define the index for Experiment 1 based on the number of configurations
bar_width = 0.35
index_exp1 = range(len(configurations))

# Plot the bars for CPU and GPU times
cpu_bars = plt.bar(index_exp1, cpu_times, bar_width, label='CPU Time')
gpu_bars = plt.bar([i + bar_width for i in index_exp1], gpu_times, bar_width, label='GPU Time')

# Add labels above each bar for CPU times
for bar in cpu_bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, yval, f'{yval:.6f}', va='bottom', ha='center', fontsize=8)

# Add labels above each bar for GPU times
for bar in gpu_bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, yval, f'{yval:.6f}', va='bottom', ha='center', fontsize=8)

# Add labels and title for Experiment 1
plt.xlabel('Configuration (Blocks, Threads per Block)')
plt.ylabel('Time (seconds)')
plt.title('Performance for varying block and thread configurations (Experiment 1)')

plt.xticks([i + bar_width / 2 for i in index_exp1], configurations, rotation=45)
plt.legend()
plt.tight_layout()
plt.savefig('plot_experiment1.png')
plt.show()

# Plot for Experiment 2 (CPU vs GPU times for varying input sizes)
plt.figure(figsize=(12, 6))  # Increase the figure size for better spacing
input_sizes = exp2_data['input_size']
cpu_times = exp2_data['cpu_time']
gpu_times = exp2_data['gpu_time']

# Define the index for Experiment 2 based on the number of input sizes
index_exp2 = range(len(input_sizes))

# Plot the bars for CPU and GPU times
bar_width = 0.35
cpu_bars = plt.bar(index_exp2, cpu_times, bar_width, label='CPU Time')
gpu_bars = plt.bar([i + bar_width for i in index_exp2], gpu_times, bar_width, label='GPU Time')

# Add labels above each bar for CPU times
for bar in cpu_bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, yval, f'{yval:.6f}', va='bottom', ha='center', fontsize=8)

# Add labels above each bar for GPU times
for bar in gpu_bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, yval, f'{yval:.6f}', va='bottom', ha='center', fontsize=8)

# Add labels and title for Experiment 2
plt.xlabel('Input Size (elements)')
plt.ylabel('Time (seconds)')
plt.title('Performance for varying input sizes (Experiment 2)')

plt.xticks([i + bar_width / 2 for i in index_exp2], input_sizes, rotation=45, ha='right')
plt.legend()
plt.tight_layout()
plt.savefig('plot_experiment2.png')
plt.show()