#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Multiplica matriz por vetor, itera por linha antes
void row_column_mul(int **matrix, int *array, int n, int *result) {
    for (int i = 0; i < n; i++) {
        result[i] = 0;
        for (int j = 0; j < n; j++) {
            result[i] = result[i] + matrix[i][j] * array[j];
        }
    }
}

// Multiplica matriz por vetor, itera por coluna antes
void column_row_mul(int **matrix, int *array, int n, int *result) {
    for (int j = 0; j < n; j++) {
        for (int i = 0; i < n; i++) {
            result[i] += matrix[i][j] * array[j];
        }
    }
}

int main(int argc, char *argv[]) {
    
    // Inicializa variaveis
    clock_t start, end;
    float total_time;
    srand(time(NULL));
    
    // Pega tamanho da matriz e do vetor 
    int n = atoi(argv[1]);
    int order = atoi(argv[2]);
    
    // Cria matriz
    int **matrix = (int **)malloc(n * sizeof(int *));
    for (int i = 0; i < n; i++) {
        matrix[i] = (int *)malloc(n * sizeof(int));
    }
    
    // Cria vetores de entrada e de resultado
    int *array = (int *)malloc(n * sizeof(int));
    int *result = (int *)malloc(n * sizeof(int));
    
    // Preenche matriz com inteiros aleatorios
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            matrix[i][j] = rand() % 101;
        }
    }

    // Preenche o vetor com numeros aleatorios
    for (int i = 0; i < n; i++) {
        array[i] = rand() % 101;
    }
    
    // Inicia o relogio
    start = clock();

    if (order == 1) {
        row_column_mul(matrix, array, n, result);
    }
    else if (order == 0){
        column_row_mul(matrix, array, n, result);
    }
    else {
        printf("Por favor, selecione uma ordem valida");
    }

    // Para o relogio e calcula tempo total
    end = clock();
    total_time = ((float)(end - start)) / CLOCKS_PER_SEC; // Gets total time taken by the operation

    // Imprime tempo total
    printf("Time taken: %f\n", total_time);

    // Abre arquivo e escreve tempo total, dependendo da ordem do produto
    if (order == 1) {
        FILE *fp = fopen("c_row_col.txt", "a");
        fprintf(fp, "n = %d, X = %.8f\n", n, total_time);
        fclose(fp);
    }
    else if (order == 0){
        FILE *fp = fopen("c_col_row.txt", "a");
        fprintf(fp, "n = %d, X = %.8f\n", n, total_time);
        fclose(fp);
    }
    

    // Libera memoria alocada
    for (int i = 0; i < n; i++) {
        free(matrix[i]);
    }
    free(matrix);
    free(array);
    free(result);

    return 0;
}