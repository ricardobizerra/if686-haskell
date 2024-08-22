import java.util.Random;

class Queue {
  class Node {
    int data;
    Node next;

    public Node(int data) {
      this.data = data;
      this.next = null;
    }
  }

  private Node head;
  private Node tail;

  public Queue() {
    this.head = null;
    this.tail = null;
  }

  public void insert(int data) {
    Node node = new Node(data);
    if (head == null) {
      head = node;
      tail = node;
    } else {
      tail.next = node;
      tail = node;
    }
  }

  public int getFirst() {
    if (head == null) {
      return -1;
    }
    int data = head.data;
    head = head.next;
    return data;
  }

  public int checkFirst() {
    if (head == null) {
      return -1;
    }
    return head.data;
  }

  public boolean isEmpty() {
    return head == null;
  }

  public int getSize() {
    int size = 0;
    Node current = head;
    while (current != null) {
      size++;
      current = current.next;
    }
    return size;
  }
}

class Producer implements Runnable {
  private Queue queue;
  private final int capacity;

  public Producer(Queue queue, int capacity) {
    this.queue = queue;
    this.capacity = capacity;
  }

  @Override
  public void run() {
    Random random = new Random();
    while (true) {
      synchronized (queue) {
        while (queue.getSize() == capacity) {
          try {
            queue.wait();
          } catch (InterruptedException e) {
            e.printStackTrace();
          }
        }

        int value = random.nextInt(1000);
        queue.insert(value);

        System.out.println("Produziu: " + value);

        queue.notifyAll();
      }
    }
  }
}

class Consumer implements Runnable {
  private Queue queue;
  private boolean consumeEven;

  public Consumer(Queue queue, boolean consumeEven) {
    this.queue = queue;
    this.consumeEven = consumeEven;
  }

  @Override
  public void run() {
    while (true) {
      synchronized (queue) {
        while (queue.isEmpty() || (consumeEven && queue.checkFirst() % 2 != 0) || (!consumeEven && queue.checkFirst() % 2 == 0)) {
          try {
            queue.wait();
          } catch (InterruptedException e) {
            e.printStackTrace();
          }
        }

        int value = queue.getFirst();

        if (consumeEven) {
          System.out.println("Consumiu par: " + value);
        } else {
          System.out.println("Consumiu ímpar: " + value);
        }

        queue.notifyAll();
        
        try {
          Thread.sleep(1000);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
    }
  }
}

public class Question3 {
  public static void main(String[] args) {
    Queue queue = new Queue();
    int capacity = 1;

    Producer producer = new Producer(queue, capacity);
    Consumer consumerEven = new Consumer(queue, true);
    Consumer consumerOdd = new Consumer(queue, false);

    Thread producerThread = new Thread(producer);
    Thread consumerEvenThread = new Thread(consumerEven);
    Thread consumerOddThread = new Thread(consumerOdd);

    producerThread.start();
    consumerEvenThread.start();
    consumerOddThread.start();
  }
}
