#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *arquivo = fopen("./AssemblyCaioFilgueiras.asm", "r");
    if (!arquivo) {
        perror("Erro ao abrir o arquivo de entrada");
        return EXIT_FAILURE;
    }

    FILE *binario = fopen("ArquivoBinario", "wb");
    if (!binario) {
        perror("Erro ao abrir o arquivo binário");
        fclose(arquivo);
        return EXIT_FAILURE;
    }

    char codigo[256]; // Buffer para armazenar a linha lida
    char add[] = "0001";
    char sub[] = "0010";

    while (fgets(codigo, sizeof(codigo), arquivo)) {
        // Remover o caractere de nova linha, se presente
        codigo[strcspn(codigo, "\n")] = '\0';

        if (strcmp(codigo, "ADD") == 0) {
            fwrite(add, sizeof(char), strlen(add), binario);
        } else if (strcmp(codigo, "SUB") == 0) {
            fwrite(sub, sizeof(char), strlen(sub), binario);
        } else {
            fwrite(codigo, sizeof(char), strlen(codigo), binario);
        }
    }

    fclose(arquivo);
    fclose(binario);
    return 0;
}
