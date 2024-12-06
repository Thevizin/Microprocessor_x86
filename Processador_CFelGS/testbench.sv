module tb_rca_4bit;
    reg [3:0] A, B;       // Entradas de 4 bits
    wire [3:0] Sum;       // Saída da soma
    wire Cout;            // Carry final

    // Instanciação do módulo rca_4bit
    rca_4bit DUT (
        .Sum(Sum),
        .Cout(Cout),
        .A(A),
        .B(B)
    );

    // Simulação de entrada
    initial begin
        $display("A      B      | Sum    Cout");
        $monitor("%b  %b  | %b  %b", A, B, Sum, Cout);

        // Teste 1: A = 4'b0001, B = 4'b0010 (ADD)
        A = 4'b0001;
        B = 4'b0010;
        #10;

        // Teste 2: A = 4'b0100, B = 4'b0011 (SUB ou equivalente)
        A = 4'b0100;
        B = 4'b0011;
        #10;

        // Teste 3: A = 4'b1111, B = 4'b0001 (Carry out esperado)
        A = 4'b1111;
        B = 4'b0001;
        #10;

        // Teste 4: A = 4'b1010, B = 4'b0101
        A = 4'b1010;
        B = 4'b0101;
        #10;

        $finish;
    end
endmodule

