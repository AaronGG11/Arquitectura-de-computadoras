#include <iostream>
#include <stdlib.h>
using namespace std;

class archivoRegistros{

    public : unsigned int banco[16];
             unsigned int writeData; 

    private : 
        unsigned int readDataOne;
        unsigned int readDataTwo;
        unsigned short writeRegister;
        unsigned short readRegisterOne;
        unsigned short readRegisterTwo;
        unsigned short shamt;
        bool wr;
        bool she;
        bool dir;
        bool clr;
        
    public : 
        archivoRegistros(); // constructor
        ~archivoRegistros(); // destructor
        void set();
        void get();
        void operacionSincrona(unsigned int _writeData, unsigned short _writeReg, unsigned short _shamt, unsigned short _readReg1, bool _wr, bool _she, bool _dir, bool _clr);
        void operacionAsincrona(bool _clr);
        void operacionAsincrona(bool _clr, unsigned short _readReg1, unsigned short _readReg2);
};


// constructor 
archivoRegistros::archivoRegistros(){

}

// destructor
archivoRegistros::~archivoRegistros(){

}

/* Método set(): 
    Inicializará cada una de las localidades del archivo con enteros aleatorios */
void archivoRegistros::set(){

    srand((unsigned)time(NULL));

    writeData = 0 + rand() % 65536; // 65536 = 2^16
    readDataOne = 0 + rand() % 65536; 
    readDataTwo = 0 + rand() % 65536;
    writeRegister = 0 + rand() % 16; // 16 = 2^4
    readRegisterOne = 0 + rand() % 16;
    readRegisterTwo = 0 + rand() % 16;
    shamt = 0 + rand() % 16;

    clr = 0 + rand() % 2; // numero aleatorio 0 ó 1
    wr = 0 + rand() % 2;
    she = 0 + rand() % 2;
    dir = 0 + rand() % 2;

    // llenar el banco de registros con nuemros aleatorios entre 0 y 255
    for(int i=0; i<sizeof(banco)/sizeof(banco[0]); i++){
        banco[i] = 0 + rand() % 256;
    }
}

/* Metodo get(): 
    Recorrerá el arreglo desde la localidad 0 hasta la 15 y mostrará su contenido. */
void archivoRegistros::get(){
    for(int i=0; i<sizeof(banco)/sizeof(banco[0]); i++){
        cout<<"["<<i<<"]["<<banco[i]<<"] ";
    }
    cout<<endl;
}

/* Método operacionSincrona(writeData, writeReg, shamt, readReg1, WR, SHE, DIR, clr): 
    Realizará la operación correspondiente a una combinación de parámetros válida con respecto a la tabla de comportamiento. 
    Este método no imprimirá nada en pantalla y debe considerar el caso en el que se reciba una combinación deparámetros incorrecta. */
void archivoRegistros::operacionSincrona(unsigned int _writeData, unsigned short _writeReg, unsigned short _shamt, unsigned short _readReg1, bool _wr, bool _she, bool _dir, bool _clr){
    if(!(_clr&1)){ // si clr == 0
        if(_wr){ // wr == 1
            if(_she == 1){ // she == 1
                if(_dir == 1){ // dir == 1
                    banco[_writeReg] = banco[_readReg1] << _shamt;
                }
                else{ // dir == 0
                    banco[_writeReg] = banco[_readReg1] >> _shamt;
                }
            }
            else{ // she == 0
                banco[_writeReg] = _writeData;
            }
        }
        else{ // se queda igual, banco = banco 
            if(she == 0 && dir == 0){
                for(int i=0; i < sizeof(banco)/sizeof(banco[0]); i++){
                    banco[i] = banco[i];
                }
            }
        }
    }
}

/* Método operacionAsincrona(clr): 
    Realizará la operación de reset, es decir, inicializará todas las localidades en 0, no es necesario que el resultado de la
    operación se muestre en pantalla. */
void archivoRegistros::operacionAsincrona(bool _clr){
    if(_clr){ // clr == 1
        for(int i=0; i<sizeof(banco)/sizeof(banco[0]); i++){
            banco[i] = 0;
        }
    }
}

/* Método operacionAsincrona(clr, readReg1, readReg2): 
Realizará la lectura de las localidades readReg1 y readReg2. */
void archivoRegistros::operacionAsincrona(bool _clr, unsigned short _readReg1, unsigned short _readReg2){
    // se desprecia a clr
    readDataOne = banco[_readReg1];
    readDataTwo = banco[_readReg2];
    
    cout << "readData1 = " << readDataOne << endl;
    cout << "readData2 = " << readDataTwo << endl;
}


int main(int argc, char const *argv[]){
    archivoRegistros a_r = archivoRegistros();
    a_r.set(); // inicializamos el banco con valores aleatorios 
    char selector;
    short opcion;

    cout<< "Practica 5" << endl;
    do{
        cout<< "1. Modificar banco de registros" << endl;
        cout << "2. Reset" << endl;
        cout << "3. get" << endl;
        cout << "4. Operacion sincrona" << endl;
        cout << "5. Operacion asincrona" << endl;
        cout <<"Selecciona una opcion: ";
        cin >> opcion;

        switch (opcion){
        case 1:
            short pos;
            unsigned int value;
            cout << "Localidad a modificar[0-15]: "; cin >> pos;
            cout << "Valor a escribir[0-65535]: "; cin >> value;

            a_r.operacionSincrona(value,pos,0,a_r.banco[pos], 1, 0, 0, 0);

            a_r.banco[pos] = value;
            break;
        case 2:
            a_r.operacionAsincrona(1); // clr prendido 
            break;
        case 3:
            a_r.get();
            break;
        case 4:
            unsigned short shamt;
            bool wr,she,dir,clr; 

            cout << "Valor de clr: "; cin >> clr;
            cout << "Valor de wr: "; cin >> wr;
            cout << "Valor de she: "; cin >> she;
            cout << "Valor de dir: ";cin >> dir;

            if(!(clr&1)){ // si clr == 0
                unsigned short writeReg;
                unsigned short readReg1;
                unsigned short shamt;
                if(wr){ // wr == 1
                    unsigned short writeReg;
                    cout << "Valor de writeReg: "; cin >> writeReg;
                    if(she == 1){ // she == 1
                        unsigned short readReg1;
                        cout << "Valor de readReg1: "; cin >> readReg1;
                        unsigned short shamt;
                        cout << "Valor de shamt: "; cin >> shamt;
                        a_r.operacionSincrona(a_r.writeData,writeReg,shamt,readReg1,1,1,dir,0);
                    }
                    else{ // she == 0
                        unsigned int writeData;
                        cout << "Valor de writeData: "; cin >> writeData;
                        a_r.operacionSincrona(writeData, writeReg, 0, writeReg, wr, she, dir, clr);
                    }
                }
            }
            break;
        case 5:
            short d1, d2;
            cout << "Localidad de registro 1[0-15]: "; cin >> d1;
            cout << "Localidad de registro 2[0-15]: "; cin >> d2;  

            a_r.operacionAsincrona(0,d1,d2);       
            break;
        default:
            break;
        }

        cout<<"Realizar otra prueba?[S/N]: ";
        cin>>selector;
    }while(selector == 'S' || selector == 's');

    return 0;
}
