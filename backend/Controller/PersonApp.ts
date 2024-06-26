import { Request, Response } from "express";
import { pool } from "../db"
import { CreateIdPersona } from "../Services/CreateID";

class ControllPerson {

    static async InsertPer(req: Request, res: Response): Promise<void> {

        const { nombrecompleto, pais, departamento, direccion } = req.body
        try {
            const result = await pool.query('SELECT * FROM persona')
            const id = CreateIdPersona(result.rows.length)
            console.log(id)
            await pool.query('INSERT INTO persona  (idpersona,nombrecompleto,pais,departamento,direccion) VALUES ($1,$2,$3,$4,$5)', [id, nombrecompleto, pais, departamento, direccion])

            res.json({ message: "Persona creado" })
        } catch (error) {
            res.json({ message: "Fallo en la peticion" }).status(404)
            return
        }

    }



    static async UpdatePer(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        const { nombrecompleto, pais, departamento, direccion } = req.body

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