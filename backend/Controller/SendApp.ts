import { Request, Response } from "express";
import { pool } from "../db"

class ControllerAppSendData {

    static async SendPais(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        console.log('entro aqui')
        if (id.length < 5) {
            res.json({ message: "ID Incorrecto" })
            return
        }
        try {
            const result = await pool.query('SELECT * FROM pais WHERE pais = $1', [id])
            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }

    }



    static async SendDepartamento(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        if (id.length < 5) {
            res.json({ message: "ID Incorrecto" })
            return
        }
        try {
            const result = await pool.query('SELECT * FROM departamento WHERE depto = $1', [id])
            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }




    static async SendPersona(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        if (+id <= 0) {
            res.json({ message: "No se un numero" })
            return
        }
        try {
            const result = await pool.query('SELECT * FROM persona WHERE idpersona = $1', [id])
            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }



}






export default ControllerAppSendData