export interface persona {
    idpersona: number,
    direccion: string,
    nombrecompleto: string,
    nomdepto: string,
    nompais: string,
}


export interface pais {
    pais: number,
    nompais: string,
}

export interface departamento {
    depto: string
    pais: string,
    nomdepto: string,
}