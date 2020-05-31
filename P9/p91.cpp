#include <iostream>
#include <stdlib.h>
#include <cstdlib>
#include <fstream>
#include <string>
#include <iterator>
#include <sstream>

using namespace std;

int CLK = 1;                    // senial de reloj

class pila{
    // attributes 

    public:
        unsigned int PC_pila[8];// 16 bits
        unsigned short SP;      // 3 bits

    private:
        unsigned int PC_in;     // 16 bits
        unsigned int PC_out;    // 16 bits
        unsigned short SP_out;  // 3 bits

    // methods
    public:
        pila(); // constructor
        ~pila(); // destructor
        void set();
        void get();
        void operacion(unsigned int _PCin, bool _UP, bool _DW, bool _WPC, bool _clr);
        void operacion();
};

// constructor 
pila::pila(){

}

// destructor
pila::~pila(){

}

/* method set
    Inicializará a los contadores con números aleatorios, así como al
    apuntado de pila */
void pila::set(){
    srand((unsigned)time(NULL));

    // llenar los contadores numeros aleatorios entre 
    for(int i=0; i<sizeof(PC_pila)/sizeof(PC_pila[0]); i++){ // 8 veces se hace
        PC_pila[i] = 0x0000 + rand() % 0xffff; // rango = [0, 2^16 )
    }

    SP = 0x0 + rand() % 0x8; // rango = [0, 8)
}

/* method get
    Permitirá obtener el contenido de todos los contadores de programa,
    mediante su direccionamiento a través del apuntador de pila. */
void pila::get(){
    cout << "SP now: " << SP << endl;

    for(int _SP=0; _SP<sizeof(PC_pila)/sizeof(PC_pila[0]); _SP++){
        cout << "\tPC[" <<_SP << "]: " << PC_pila[_SP] << endl;
    }
}

/* method operacion
    Realizará la operación correspondiente
    a una combinación de parámetros válida con respecto a la tabla de comportamiento.
    Este método no imprimirá nada en pantalla y debe considerar el caso en el que se
    reciba una combinación de parámetros incorrecta. */
void pila::operacion(unsigned int _PCin, bool _UP, bool _DOWN, bool _WPC, bool _clr){

    PC_in = _PCin;

    // No importa ninguna de las seniales, hara lectura, pero para eso se encarga la sobrecarga de este metodo 
    if(_clr){ // esta activado el clr
        SP = 0x0;
        for(int i=0; i<sizeof(PC_pila)/sizeof(PC_pila[0]); i++){
            PC_pila[i] = 0x0000;
        }
    }
    else{ // no esta activado el clear
        if(CLK){ // si hay flanco de subida
            if((!(_WPC&1)) && (!(_UP&1)) && (!(_DOWN&1))){ // wpc = up = down = 0
                // SP = SP;
                PC_pila[SP]++;
            }
            else if(_WPC && (!(_UP&1)) && (!(_DOWN&1))){ //  up = down = 0, wpc = 1
                // SP = SP;
                PC_pila[SP] = _PCin;
            }
            else if(_WPC && _UP && (!(_DOWN&1))){ // down = 0, wpc = up = 1
                SP=SP+1;
                PC_pila[SP] = _PCin;
            }
            else if((!(_WPC&1)) && (!(_UP&1)) && _DOWN){ // wpc = up = 0, down = 1
                SP=SP-1;
                PC_pila[SP]++;
            }
            else{ // combinación de parámetros incorrecta
                cout << "combinación de parámetros incorrecta, intenta con operacion()" << endl;
            }
        }
    }
}

/* method operacion
    Realizará la lectura del contador de programa al cual esté
    apuntando el stack pointer. */
void pila::operacion(){
    PC_out = PC_pila[SP];
    SP_out = SP;
    cout << "PC[" << SP << "]: " << PC_out << endl;
}

unsigned int countWordsInString(std::string const& str)
{
       std::stringstream stream(str);
       return std::distance(std::istream_iterator<std::string>(stream), std::istream_iterator<std::string>());
}


int main(int argc, char const *argv[]){
    system("clear");
    pila stack = pila();
    stack.set();

    char selector;
    short opcion;

    cout<< "Practica 9" << endl;
    do{
        cout << "1. Reset" << endl;
        cout << "2. Get" << endl;
        cout << "3. Escritura" << endl;
        cout << "4. Lectura" << endl;
        cout <<"Selecciona una opcion: ";
        cin >> opcion;

        ifstream archivo_entrada("instrucciones.txt");
        string linea;

        switch (opcion){
            case 1:{
                stack.operacion(0x0000,0,0,0,1); // solo importan los parametros de los extremos
                break;
            }
            case 2:{
                stack.get();
                break;
            }
            case 3:{
                int contador = 0;
                while(getline(archivo_entrada, linea)) {

                    string word; 
                    stringstream iss(linea); 
                    string resultado[countWordsInString(linea)];
                    int cont = 0;

                    while (iss >> word) {
                        resultado[cont] = word;
                        cont++;
                    }

                    if((resultado[0] == "BEQI") || (resultado[0] == "BNEI") || (resultado[0] == "BLTI") ||
                        (resultado[0] == "BLETI") || (resultado[0] == "BGTI") || (resultado[0] == "BGETI")){
                        unsigned int aux = stack.PC_pila[stack.SP] + stoi(resultado[3]);
                        stack.operacion(aux,0,0,1,0);
                    }
                    else if(resultado[0] == "B"){
                        stack.operacion(stoi(resultado[1]),0,0,1,0);
                    }
                    else if(resultado[0] == "CALL"){
                        stack.operacion(stoi(resultado[1]),1,0,1,0);
                    }
                    else if(resultado[0] == "RET"){
                        stack.operacion(0x0, 0,1,0,0);
                    }
                    else{
                        stack.operacion(0x0,0,0,0,0);
                    }
                    cout << "Linea - " << contador + 1 << endl;
                    stack.get();
                    
                    contador++;
                    cout.flush();
                }
                break;
            }
            case 4:{
                stack.operacion();
                break;
            }
            default:{
                break;
            }
        }

        cout<<"Realizar otra prueba?[S/N]: ";
        cin>>selector;
    }while(selector == 'S' || selector == 's');

    return 0;
}

