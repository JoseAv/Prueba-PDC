import { useStore } from '../Store/Data'


export function InfoPais() {
    const pais = useStore((state) => state.pais)

    return (
        <div className="container-table">
            <h2>Pais</h2>
            <table>
                <thead>
                    <tr>
                        <th>Codigo Pais</th>
                        <th>Nombre Pais</th>
                    </tr>
                </thead>
                <tbody>
                    {pais.map(pa => (
                        <tr key={pa.pais}>
                            <td>{pa.pais}</td>
                            <td>{pa.nompais}</td>

                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export function InfoDepartamento() {
    const departamento = useStore((state) => state.dep)
    console.log(departamento)
    return (
        <div className="container-table">
            <h2>Departamento</h2>
            <table>
                <thead>
                    <tr>
                        <th>Codigo Pais</th>
                        <th>Departamento</th>
                        <th>Nombre Departamento</th>
                    </tr>
                </thead>
                <tbody>


                    {departamento.map((dep, index) => (
                        <tr key={index}>
                            <td>{dep.pais}</td>
                            <td>{dep.depto}</td>
                            <td>{dep.nomdepto}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export function InfoPersona() {
    const persona = useStore((state) => state.persona)
    return (
        <div className="container-table">
            <h2>Persona</h2>
            <table>
                <thead>
                    <tr>
                        <th>Id Persona</th>
                        <th>Nombre Completo</th>
                        <th>Pais</th>
                        <th>Departamento</th>
                        <th>Direccion</th>
                    </tr>
                </thead>
                <tbody>


                    {persona.map(per => (
                        <tr key={per.idpersona}>
                            <td>{per.idpersona}</td>
                            <td>{per.nombrecompleto}</td>
                            <td>{per.nompais}</td>
                            <td>{per.nomdepto}</td>
                            <td>{per.direccion}</td>
                        </tr>
                    ))}

                </tbody>
            </table>
        </div>
    );
}
