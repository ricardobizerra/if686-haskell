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
    // using 50 threads to insert 100000 values
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