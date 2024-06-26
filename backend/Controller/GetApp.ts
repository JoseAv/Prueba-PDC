import { Request, Response } from "express";
import { pool } from "../db"
import { CreateIDDepartament, CreateIDPais } from "../Services/CreateID";

class ControllGetApp {

    static async InsertPais(req: Request, res: Response): Promise<void> {
        const { nompais } = req.body
        try {
            const result = await pool.query('SELECT * FROM pais')
            const id = CreateIDPais(result.rows.length)
            await pool.query('INSERT INTO pais  (pais,nompais) VALUES ($1,$2)', [id, nompais])

            res.json({ message: "Pais creado" })
        } catch (error) {
            res.json({ message: "Fallo en la peticion" }).status(404)
            return
        }

    }



    static async UpdatePais(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        const { nompais } = req.body

        try {
            const result = await pool.query('UPDATE pais SET nompais = $1 WHERE pais = $2 ', [nompais, id])
            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }


    static async InsertDep(req: Request, res: Response): Promise<void> {
        const { nomdepto, pais } = req.body
        console.log(nomdepto, pais)
        try {
            const result = await pool.query('SELECT * FROM departamento')

            const id = CreateIDDepartament(result.rows.length)
            await pool.query('INSERT INTO departamento  (pais,depto,nomdepto) VALUES ($1,$2,$3)', [pais, id, nomdepto])

            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" }).status(404)
            return
        }

    }



    static async UpdateDep(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        const { nomdepto } = req.body
        console.log(id, nomdepto)
        try {
            const result = await pool.query('UPDATE departamento SET nomDepto = $1 WHERE depto = $2 ', [nomdepto, id])
            res.json(result.rows)
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }


}

export default ControllGetApp
