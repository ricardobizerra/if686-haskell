// Aluno: Ricardo Bizerra de Lima Filho
// Login: rblf
// Matrícula: 20220028051

// Questão 1

// Letra A

class ArvoreBusca {
  class No {
    double valor;
    No esquerda;
    No direita;

    public No(double valor) {
      this.valor = valor;
      this.esquerda = null;
      this.direita = null;
    }
  }

  private No raiz;

  public ArvoreBusca() {
    this.raiz = null;
  }

  synchronized public void inserir(double valor) {
    if (raiz == null) {
      raiz = new No(valor);
    } else {
      inserirRecursivo(raiz, valor);
    }
  }

  public void inserirRecursivo(No no, double valor) {
    if (valor < no.valor) {
      if (no.esquerda == null) {
        no.esquerda = new No(valor);
      } else {
        inserirRecursivo(no.esquerda, valor);
      }
    } else {
      if (no.direita == null) {
        no.direita = new No(valor);
      } else {
        inserirRecursivo(no.direita, valor);
      }
    }
  }

  public int getTotalNodes() {
    return constructTotal();
  }

  public int constructTotal() {
    return constructTotalRecursivo(raiz);
  }

  public int constructTotalRecursivo(No no) {
    if (no == null) {
      return 0;
    }

    return 1 + constructTotalRecursivo(no.esquerda) + constructTotalRecursivo(no.direita);
  }
}

class ThreadArvoreBusca extends Thread {
  private ArvoreBusca arvore;

  public ThreadArvoreBusca(ArvoreBusca arvore) {
    this.arvore = arvore;
  }

  public void run() {
    for (int i = 0; i < 2000; i++) {
      double randomValue = Math.random();
      this.arvore.inserir(randomValue);
    }
  }
}

public class Question1 {
  public static void main (String[] args) {
    long startTime = System.currentTimeMillis();
    Thread[] threads = new Thread[50];
    ArvoreBusca arvore = new ArvoreBusca();
  
    for (int i = 0; i < 50; i++) {
      threads[i] = new ThreadArvoreBusca(arvore);
    }
  
    for (int i = 0; i < 50; i++) {
      threads[i].start();
    }
  
    for (int i = 0; i < 50; i++) {
      try {
        threads[i].join();
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    System.out.println("EXECUÇÃO COM 50 THREADS");
    System.out.println("Total de nós: " + arvore.getTotalNodes());
    System.out.println("Tempo de execução: " + (System.currentTimeMillis() - startTime) + "ms");

    startTime = System.currentTimeMillis();
    ArvoreBusca arvore2 = new ArvoreBusca();
    for (int i = 0; i < 2000 * 50; i++) {
      double randomValue = Math.random();
      arvore2.inserir(randomValue);
    }

    System.out.println("\nEXECUÇÃO SEQUENCIAL");
    System.out.println("Total de nós: " + arvore2.getTotalNodes());
    System.out.println("Tempo de execução: " + (System.currentTimeMillis() - startTime) + "ms");
  }
}

// Letra B

// Tempo de execução da versão com 50 threads: 56ms
// Tempo de execução da versão sequencial: 29ms

// Questão 2

class ArvoreBuscaGranular {
  class No {
    double valor;
    No esquerda;
    No direita;
    
    public No(double valor) {
      this.valor = valor;
      this.esquerda = null;
      this.direita = null;
    }
  }
  
  private No raiz;
  
  public ArvoreBuscaGranular() {
    this.raiz = null;
  }
  
  public void inserir(double valor) {
    if (raiz == null) {
      raiz = new No(valor);
    } else {
      inserirRecursivo(raiz, valor);
    }
  }
  
  public void inserirRecursivo(No no, double valor) {
    if (valor < no.valor) {
      if (no.esquerda == null) {
        synchronized (no) {
          no.esquerda = new No(valor);
        }
      } else {
        inserirRecursivo(no.esquerda, valor);
      }
    } else {
      if (no.direita == null) {
        synchronized (no) {
          no.direita = new No(valor);
        }
      } else {
        inserirRecursivo(no.direita, valor);
      }
    }
  }
  
  public int getTotalNodes() {
    return constructTotal();
  }
  
  public int constructTotal() {
    return constructTotalRecursivo(raiz);
  }
  
  public int constructTotalRecursivo(No no) {
    if (no == null) {
      return 0;
    }
    
    return 1 + constructTotalRecursivo(no.esquerda) + constructTotalRecursivo(no.direita);
  }
}

class ThreadArvoreBuscaGranular extends Thread {
  private ArvoreBuscaGranular arvore;
  
  public ThreadArvoreBuscaGranular(ArvoreBuscaGranular arvore) {
    this.arvore = arvore;
  }
  
  public void run() {
    for (int i = 0; i < 2000; i++) {
      double randomValue = Math.random();
      this.arvore.inserir(randomValue);
    }
  }
}

public class Question2 {
  public static void main (String[] args) {
    long startTime = System.currentTimeMillis();
    Thread[] threads = new Thread[50];
    ArvoreBuscaGranular arvore = new ArvoreBuscaGranular();
    
    for (int i = 0; i < 50; i++) {
      threads[i] = new ThreadArvoreBuscaGranular(arvore);
    }
    
    for (int i = 0; i < 50; i++) {
      threads[i].start();
    }
    
    for (int i = 0; i < 50; i++) {
      try {
        threads[i].join();
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }
    
    System.out.println("EXECUÇÃO COM 50 THREADS");
    System.out.println("Total de nós: " + arvore.getTotalNodes());
    System.out.println("Tempo de execução: " + (System.currentTimeMillis() - startTime) + "ms");
    
    startTime = System.currentTimeMillis();
    ArvoreBuscaGranular arvore2 = new ArvoreBuscaGranular();
    for (int i = 0; i < 2000 * 50; i++) {
      double randomValue = Math.random();
      arvore2.inserir(randomValue);
    }
    
    System.out.println("\nEXECUÇÃO SEQUENCIAL");
    System.out.println("Total de nós: " + arvore2.getTotalNodes());
    System.out.println("Tempo de execução: " + (System.currentTimeMillis() - startTime) + "ms");
  }
}

// Tempo de execução da versão com 50 threads, com granularidade por nó: 45ms
// Tempo de execução da versão com 50 threads, com granularidade por árvore: 56ms
// Tempo de execução da versão sequencial: 26ms

// Questão 3

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
