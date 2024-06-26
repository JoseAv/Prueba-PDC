

export function CreateIdPersona(number: number): Number {
    const NumeroNuevo = number + 1
    return NumeroNuevo
}


export function CreateIDPais(number: number): string {
    let NumeroNuevo = number + 1
    console.log(NumeroNuevo)
    let id = "PA001"
    if (number === 0) return id
    if (NumeroNuevo <= 9) return id = `PA00${NumeroNuevo}`
    if (NumeroNuevo <= 99) return id = `PA0${NumeroNuevo}`
    if (NumeroNuevo <= 999) return id = `PA${NumeroNuevo}`

    return ''

}



export function CreateIDDepartament(number: number): string {
    let NumeroNuevo = number + 1
    let id = "DE001"
    if (number === 0) return id
    if (NumeroNuevo <= 9) return id = `DE00${NumeroNuevo}`
    if (NumeroNuevo <= 99) return id = `DE0${NumeroNuevo}`
    if (NumeroNuevo <= 999) return id = `DE${NumeroNuevo}`

    return ''

}
