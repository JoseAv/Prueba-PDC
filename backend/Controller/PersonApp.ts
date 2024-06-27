import { Request, Response } from "express";
import { pool } from "../db"
import { CreateIdPersona } from "../Services/CreateID";
import { validateDep, validatePais } from "../Services/Validate";




class ControllPerson {

    static async InsertPer(req: Request, res: Response): Promise<void> {

        let { nombrecompleto, pais, departamento, direccion } = req.body;
        if (nombrecompleto === "") nombrecompleto = 'No Data';
        if (direccion === "") direccion = 'Sin Direccion';

        try {
            let comprobepais = await validatePais(pais);

            if (!comprobepais) {
                res.status(404).json({ message: "No Existe este pais" });
                return;
            }


            let comprobeDep = await validateDep(departamento);

            if (!comprobeDep) {
                res.status(404).json({ message: "No Existe este Departamento" });
                return;
            }


            const result = await pool.query('SELECT * FROM persona');
            const id = CreateIdPersona(result.rows.length + 1); // Suponiendo que esto genera un nuevo ID único
            console.log(id)
            await pool.query('INSERT INTO persona (idpersona, nombrecompleto, pais, departamento, direccion) VALUES ($1, $2, $3, $4, $5)',
                [id, nombrecompleto, comprobepais, comprobeDep, direccion]);

            res.json({ message: "Persona creada" });
        } catch (error) {
            console.error('Error en la inserción de persona:', error);
            res.status(500).json({ message: "Fallo en la peticion" });
        }

    }



    static async UpdatePer(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        let { nombrecompleto, pais, departamento, direccion } = req.body
        
        if (nombrecompleto === '') {
            nombrecompleto = 'No Data'
        }

        if (direccion === '') {
            direccion = 'No Direccion'
        }

        try {
            const result = await pool.query('UPDATE persona SET nombrecompleto = $1, pais=$2, departamento = $3, direccion=$4  WHERE idpersona = $5 ', [nombrecompleto, pais, departamento, direccion, id])
            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }


    static async DeletePer(req: Request, res: Response): Promise<void> {
        const { id } = req.params

        try {
            const result = await pool.query('DELETE FROM persona WHERE idpersona = $1 ', [id])
            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }



}

export default ControllPerson