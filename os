FCFS CPU
#include <stdio.h>
#include <stdlib.h>


typedef struct {
    int id;
    int arrival;
    int burst;
    int waiting;
    int turnaround;
} Process;


void fcfs(Process processes[], int n) {
    int currentTime = 0;
    int totalWaiting = 0;
    int totalTurnaround = 0;

    printf("Process Execution Order:\n");
    for (int i = 0; i < n; i++) {
        if (currentTime < processes[i].arrival)
            currentTime = processes[i].arrival;
        
        processes[i].waiting = currentTime - processes[i].arrival;
        totalWaiting += processes[i].waiting;

        processes[i].turnaround = processes[i].waiting + processes[i].burst;
        totalTurnaround += processes[i].turnaround;

        printf("Executing Process %d from time %d to time %d\n", processes[i].id, currentTime, currentTime + processes[i].burst);
        currentTime += processes[i].burst;
    }

    printf("\n");
    printf("Process\tWaiting Time\tTurnaround Time\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t%d\t\t%d\n", processes[i].id, processes[i].waiting, processes[i].turnaround);
    }

    printf("\nTotal Waiting Time: %d\n", totalWaiting);
    printf("Average Waiting Time: %.2f\n", (float)totalWaiting / n);
    printf("Total Turnaround Time: %d\n", totalTurnaround);
    printf("Average Turnaround Time: %.2f\n", (float)totalTurnaround / n);
}

int main() {
    int n;
    printf("Enter the number of processes: ");
    scanf("%d", &n);
    Process *processes = (Process *)malloc(n * sizeof(Process));
    for (int i = 0; i < n; i++) {
        printf("Enter arrival time for Process %d: ", i + 1);
        scanf("%d", &processes[i].arrival);
        printf("Enter burst time for Process %d: ", i + 1);
        scanf("%d", &processes[i].burst);
        processes[i].id = i + 1;
    }
    fcfs(processes, n);
    free(processes);

    return 0;
}

SJF CPU
#include <stdio.h>
#include <stdlib.h>


typedef struct {
    int id;       
    int arrival;  
    int burst;    
    int waiting;  
    int turnaround; 
} Process;


void sjf(Process processes[], int n) {
    int currentTime = 0; 
    int totalWaiting = 0; 
    int totalTurnaround = 0; 


    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (processes[j].arrival > processes[j + 1].arrival) {
                Process temp = processes[j];
                processes[j] = processes[j + 1];
                processes[j + 1] = temp;
            }
        }
    }

  
    printf("Process Execution Order:\n");
    for (int i = 0; i < n; i++) {
        if (currentTime < processes[i].arrival)
            currentTime = processes[i].arrival; 

        processes[i].waiting = currentTime - processes[i].arrival;
        totalWaiting += processes[i].waiting;

        processes[i].turnaround = processes[i].waiting + processes[i].burst;
        totalTurnaround += processes[i].turnaround;

        printf("Executing Process %d from time %d to time %d\n", processes[i].id, currentTime, currentTime + processes[i].burst);
        currentTime += processes[i].burst; 
    }

    printf("\n");
    printf("Process\tWaiting Time\tTurnaround Time\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t%d\t\t%d\n", processes[i].id, processes[i].waiting, processes[i].turnaround);
    }

    printf("\nTotal Waiting Time: %d\n", totalWaiting);
    printf("Average Waiting Time: %.2f\n", (float)totalWaiting / n);
    printf("Total Turnaround Time: %d\n", totalTurnaround);
    printf("Average Turnaround Time: %.2f\n", (float)totalTurnaround / n);
}

int main() {
    int n; 
    printf("Enter the number of processes: ");
    scanf("%d", &n);

   
    Process *processes = (Process *)malloc(n * sizeof(Process));

    
    for (int i = 0; i < n; i++) {
        printf("Enter arrival time for Process %d: ", i + 1);
        scanf("%d", &processes[i].arrival);
        printf("Enter burst time for Process %d: ", i + 1);
        scanf("%d", &processes[i].burst);
        processes[i].id = i + 1; 
    }

    
    sjf(processes, n);

   
    free(processes);

    return 0;
}

CP
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    FILE *sourceFile, *destinationFile;
    char ch;

    
    if (argc != 3) {
        printf("Usage: %s <source-file> <destination-file>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

   
    sourceFile = fopen(argv[1], "r");
    if (sourceFile == NULL) {
        perror("Error opening source file");
        exit(EXIT_FAILURE);
    }

   
    destinationFile = fopen(argv[2], "w");
    if (destinationFile == NULL) {
        perror("Error opening destination file");
        exit(EXIT_FAILURE);
    }

  
    while ((ch = fgetc(sourceFile)) != EOF) {
        fputc(ch, destinationFile);
    }


    fclose(sourceFile);
    fclose(destinationFile);

    printf("File copied successfully.\n");

    return 0;
}

LS
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>

int main(int argc, char *argv[]) {
    DIR *directory;
    struct dirent *entry;

    
    if (argc == 1) {
        directory = opendir(".");
    } else {
    
        directory = opendir(argv[1]);
    }

  
    if (directory == NULL) {
        perror("Error opening directory");
        exit(EXIT_FAILURE);
    }

  
    while ((entry = readdir(directory)) != NULL) {
        printf("%s\n", entry->d_name);
    }


    closedir(directory);

    return 0;
}

OPENDIR READDIR CLOSEDIR
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>

int main() {
    DIR *dir;
    struct dirent *entry;

   
    dir = opendir(".");

    
    if (dir == NULL) {
        perror("opendir");
        exit(EXIT_FAILURE);
    }

 
    while ((entry = readdir(dir)) != NULL) {
        printf("%s\n", entry->d_name);
    }

   
    closedir(dir);

    return 0;
}

FORK GETPID EXIT
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t child_pid;

   
    child_pid = fork();

   
    if (child_pid < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (child_pid == 0) {
        
        printf("Child process: PID = %d\n", getpid());
        exit(EXIT_SUCCESS); 
    } else {
        
        printf("Parent process: PID = %d, Child PID = %d\n", getpid(), child_pid);
        exit(EXIT_SUCCESS); 
    }

    return 0; 
}

Add 2 num

#!/bin/bash
echo "Enter first number:"
read num1
echo "Enter second number:"
read num2
sum=$((num1 + num2))
echo "Sum: $sum"

gretest of 3 
#!/bin/bash
echo "Enter three numbers:"
read num1 num2 num3
max=$num1
if [ $num2 -gt $max ]; then
    max=$num2
fi
if [ $num3 -gt $max ]; then
    max=$num3
fi
echo "Maximum number: $max"

factorial of given number

#!/bin/bash
echo "Enter a number:"
read num
fact=1
for ((i=1; i<=num; i++)); do
    fact=$((fact * i))
done
echo "Factorial of $num: $fact"

Area and perimeter of rectangle

#!/bin/bash
echo "Enter length of rectangle:"
read length
echo "Enter width of rectangle:"
read width
area=$((length * width))
perimeter=$((2 * (length + width)))
echo "Area: $area"
echo "Perimeter: $perimeter"

FIFO Page Replacement 

#include <stdio.h>
#include <stdbool.h>

#define NUM_FRAMES 3

int main() {
    int frames[NUM_FRAMES]; 
    int pageRequests[] = {7, 0, 1, 2, 0, 3, 0, 4, 2, 3, 0, 3, 2};  
    int numPageRequests = sizeof(pageRequests) / sizeof(pageRequests[0]);
    bool isPageFault;
    int pageFaults = 0;

   
    for (int i = 0; i < NUM_FRAMES; i++) {
        frames[i] = -1;
    }

  
    printf("Page Frames: ");
    for (int i = 0; i < numPageRequests; i++) {
        isPageFault = true;
        printf("\nPage request: %d, Page Frames: ", pageRequests[i]);
     
        for (int j = 0; j < NUM_FRAMES; j++) {
            if (frames[j] == pageRequests[i]) {
                isPageFault = false;
                break;
            }
        }
      
        if (isPageFault) {
            frames[pageFaults % NUM_FRAMES] = pageRequests[i];
            pageFaults++;
        }
       
        for (int j = 0; j < NUM_FRAMES; j++) {
            printf("%d ", frames[j]);
        }
    }
    printf("\nTotal Page Faults: %d\n", pageFaults);

    return 0;
}

LRU Page Replacement

#include <stdio.h>
#include <stdbool.h>

#define NUM_FRAMES 3

int main() {
    int frames[NUM_FRAMES]; 
    int pageRequests[] = {7, 0, 1, 2, 0, 3, 0, 4, 2, 3, 0, 3, 2};  
    int numPageRequests = sizeof(pageRequests) / sizeof(pageRequests[0]);
    int pageIndices[NUM_FRAMES]; 
    bool isPageFault;
    int pageFaults = 0;

    
    for (int i = 0; i < NUM_FRAMES; i++) {
        frames[i] = -1;
        pageIndices[i] = -1;
    }

   
    printf("Page Frames: ");
    for (int i = 0; i < numPageRequests; i++) {
        isPageFault = true;
        printf("\nPage request: %d, Page Frames: ", pageRequests[i]);
        
        for (int j = 0; j < NUM_FRAMES; j++) {
            if (frames[j] == pageRequests[i]) {
               
                pageIndices[j] = i;
                isPageFault = false;
                break;
            }
        }
     
        if (isPageFault) {
            int lruIndex = 0;
            
            for (int j = 1; j < NUM_FRAMES; j++) {
                if (pageIndices[j] < pageIndices[lruIndex]) {
                    lruIndex = j;
                }
            }
            frames[lruIndex] = pageRequests[i];
            pageIndices[lruIndex] = i;
            pageFaults++;
        }
        
        for (int j = 0; j < NUM_FRAMES; j++) {
            printf("%d ", frames[j]);
        }
    }
    printf("\nTotal Page Faults: %d\n", pageFaults);

    return 0;
}

FCFS DISK

#include <stdio.h>
#include <stdlib.h>

int main() {
    int disk_head, num_requests;

   
    printf("Enter the disk head position: ");
    scanf("%d", &disk_head);

    
    printf("Enter the number of disk requests: ");
    scanf("%d", &num_requests);

    int requests[num_requests];

    
    printf("Enter the disk requests: ");
    for (int i = 0; i < num_requests; i++) {
        scanf("%d", &requests[i]);
    }

    
    int total_seek_time = 0;
    int current_track = disk_head;

    for (int i = 0; i < num_requests; i++) {
        total_seek_time += abs(requests[i] - current_track);
        current_track = requests[i];
    }

    printf("Total seek time using FCFS: %d\n", total_seek_time);

    return 0;
}


SCAN DISK

#include <stdio.h>
#include <stdlib.h>

#define MAX_REQUESTS 1000

int main() {
    int disk_head, num_requests, start_point, end_point, direction;

    
    printf("Enter the disk head position: ");
    scanf("%d", &disk_head);

    
    printf("Enter the number of disk requests: ");
    scanf("%d", &num_requests);

    
    int requests[num_requests];
    printf("Enter the disk requests: ");
    for (int i = 0; i < num_requests; i++) {
        scanf("%d", &requests[i]);
    }

   
    printf("Enter the starting point of the disk: ");
    scanf("%d", &start_point);
    printf("Enter the ending point of the disk: ");
    scanf("%d", &end_point);

    
    printf("Enter the direction of movement (0 for left, 1 for right): ");
    scanf("%d", &direction);

    
    int total_requests = num_requests + 2;
    int all_requests[MAX_REQUESTS + 2];
    all_requests[0] = start_point;
    for (int i = 1; i <= num_requests; i++) {
        all_requests[i] = requests[i - 1];
    }
    all_requests[total_requests - 1] = end_point;

    
    for (int i = 0; i < total_requests - 1; i++) {
        for (int j = i + 1; j < total_requests; j++) {
            if ((direction == 0 && all_requests[i] < all_requests[j]) || 
                (direction == 1 && all_requests[i] > all_requests[j])) {
                int temp = all_requests[i];
                all_requests[i] = all_requests[j];
                all_requests[j] = temp;
            }
        }
    }

   
    int total_seek_time = 0;
    int current_track = disk_head;
    int index = 0;

    
    for (int i = 0; i < total_requests; i++) {
        if (all_requests[i] == disk_head) {
            index = i;
            break;
        }
    }

    
    for (int i = index; i < total_requests; i++) {
        total_seek_time += abs(all_requests[i] - current_track);
        current_track = all_requests[i];
    }

    
    for (int i = index - 1; i >= 0; i--) {
        total_seek_time += abs(all_requests[i] - current_track);
        current_track = all_requests[i];
    }

    printf("Total seek time using SCAN: %d\n", total_seek_time);

    return 0;
}



Dining Philosopher

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#define NUM_PHILOSOPHERS 5

pthread_mutex_t forks[NUM_PHILOSOPHERS];
pthread_t philosophers[NUM_PHILOSOPHERS];

void *philosopher(void *arg) {
    int id = *(int *)arg;
    int left_fork = id;
    int right_fork = (id + 1) % NUM_PHILOSOPHERS;

    while (1) {
        // Thinking
        printf("Philosopher %d is thinking.\n", id);

        // Grab forks
        pthread_mutex_lock(&forks[left_fork]);
        printf("Philosopher %d picked up left fork %d.\n", id, left_fork);
        pthread_mutex_lock(&forks[right_fork]);
        printf("Philosopher %d picked up right fork %d.\n", id, right_fork);

        // Eating
        printf("Philosopher %d is eating.\n", id);
        sleep(1); // Eating for 1 second

        // Release forks
        pthread_mutex_unlock(&forks[left_fork]);
        printf("Philosopher %d put down left fork %d.\n", id, left_fork);
        pthread_mutex_unlock(&forks[right_fork]);
        printf("Philosopher %d put down right fork %d.\n", id, right_fork);
    }
    return NULL;
}

int main() {
    
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        pthread_mutex_init(&forks[i], NULL);
    }

    
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        int *id = malloc(sizeof(int));
        *id = i;
        pthread_create(&philosophers[i], NULL, philosopher, (void *)id);
    }

    
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        pthread_join(philosophers[i], NULL);
    }

   
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        pthread_mutex_destroy(&forks[i]);
    }

    return 0;
}

Bankers Algorithm

#include <stdio.h>
#include <stdbool.h>

#define MAX_RESOURCES 10
#define MAX_PROCESSES 10

int available[MAX_RESOURCES];
int maximum[MAX_PROCESSES][MAX_RESOURCES];
int allocation[MAX_PROCESSES][MAX_RESOURCES];
int need[MAX_PROCESSES][MAX_RESOURCES];
bool finish[MAX_PROCESSES];

bool is_safe(int processes[], int n);

int main() {
    int m, n; // m = number of resources, n = number of processes

    
    printf("Enter the number of resources: ");
    scanf("%d", &m);

    
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    
    printf("Enter the available resources: ");
    for (int i = 0; i < m; i++) {
        scanf("%d", &available[i]);
    }

    
    printf("Enter maximum demand of each process:\n");
    for (int i = 0; i < n; i++) {
        printf("For process %d: ", i + 1);
        for (int j = 0; j < m; j++) {
            scanf("%d", &maximum[i][j]);
        }
    }

    
    printf("Enter allocated resources for each process:\n");
    for (int i = 0; i < n; i++) {
        printf("For process %d: ", i + 1);
        for (int j = 0; j < m; j++) {
            scanf("%d", &allocation[i][j]);
            need[i][j] = maximum[i][j] - allocation[i][j];
        }
    }

   
    int process;
    printf("Enter the process number to check: ");
    scanf("%d", &process);

    if (is_safe(&process, n)) {
        printf("Process %d is safe.\n", process);
    } else {
        printf("Process %d is unsafe.\n", process);
    }

    return 0;
}


bool is_safe(int processes[], int n) {
    int work[MAX_RESOURCES];
    bool finish_copy[MAX_PROCESSES];

   
    for (int i = 0; i < MAX_RESOURCES; i++) {
        work[i] = available[i];
    }
    for (int i = 0; i < n; i++) {
        finish_copy[i] = finish[i];
    }

    
    for (int i = 0; i < MAX_RESOURCES; i++) {
        if (allocation[processes[0]][i] > need[processes[0]][i]) {
            return false;
        }
        if (allocation[processes[0]][i] > work[i]) {
            return false;
        }
        work[i] -= allocation[processes[0]][i];
    }
    finish_copy[processes[0]] = true;

    
    bool flag;
    do {
        flag = false;
        for (int i = 0; i < n; i++) {
            if (!finish_copy[i]) {
                bool temp = true;
                for (int j = 0; j < MAX_RESOURCES; j++) {
                    if (need[i][j] > work[j]) {
                        temp = false;
                        break;
                    }
                }
                if (temp) {
                    for (int j = 0; j < MAX_RESOURCES; j++) {
                        work[j] += allocation[i][j];
                    }
                    finish_copy[i] = true;
                    flag = true;
                }
            }
        }
    } while (flag);

    
    for (int i = 0; i < n; i++) {
        if (!finish_copy[i]) {
            return false;
        }
    }
    return true;
}

Semaphores

#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

#define BUFFER_SIZE 5
#define NUM_ITEMS 10

int buffer[BUFFER_SIZE];
int in = 0, out = 0;

sem_t mutex, full, empty;

void *producer(void *arg) {
    for (int i = 0; i < NUM_ITEMS; i++) {
        sem_wait(&empty);
        sem_wait(&mutex);
        buffer[in] = i;
        in = (in + 1) % BUFFER_SIZE;
        printf("Produced: %d\n", i);
        sem_post(&mutex);
        sem_post(&full);
    }
    pthread_exit(NULL);
}

void *consumer(void *arg) {
    for (int i = 0; i < NUM_ITEMS; i++) {
        sem_wait(&full);
        sem_wait(&mutex);
        int item = buffer[out];
        out = (out + 1) % BUFFER_SIZE;
        printf("Consumed: %d\n", item);
        sem_post(&mutex);
        sem_post(&empty);
    }
    pthread_exit(NULL);
}

int main() {
    pthread_t producer_thread, consumer_thread;

    sem_init(&mutex, 0, 1);
    sem_init(&full, 0, 0);
    sem_init(&empty, 0, BUFFER_SIZE);

    pthread_create(&producer_thread, NULL, producer, NULL);
    pthread_create(&consumer_thread, NULL, consumer, NULL);

    pthread_join(producer_thread, NULL);
    pthread_join(consumer_thread, NULL);

    sem_destroy(&mutex);
    sem_destroy(&full);
    sem_destroy(&empty);

    return 0;
}




gcc cp.c -o cp
./cp source-file destination-file
