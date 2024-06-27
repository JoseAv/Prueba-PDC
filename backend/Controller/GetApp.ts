import { Request, Response } from "express";
import { pool } from "../db"
import { CreateIDDepartament, CreateIDPais } from "../Services/CreateID";
import { validatePais } from '../Services/Validate'
class ControllGetApp {

    static async InsertPais(req: Request, res: Response): Promise<void> {
        let { nompais } = req.body
        if (nompais === '') {
            nompais = "Sin Ingresar"
        }
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
        let { nompais } = req.body
        if (nompais === '') {
            nompais = "Sin Ingresar"
        }



        try {
            const result = await pool.query('UPDATE pais SET nompais = $1 WHERE pais = $2 ', [nompais, id])
            res.json({ message: 'Actualizado Pais' })
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }


    static async InsertDep(req: Request, res: Response): Promise<void> {
        let { nomdepto, pais } = req.body
        if (nomdepto === "") {
            nomdepto = "Sin Data"
        }

        try {

            let comprobepais = await validatePais(pais);

            if (!comprobepais) {
                res.status(404).json({ message: "No Existe este pais" });
                return;
            }

            const result = await pool.query('SELECT * FROM departamento')

            const id = CreateIDDepartament(result.rows.length)
            await pool.query('INSERT INTO departamento  (pais,depto,nomdepto) VALUES ($1,$2,$3)', [comprobepais, id, nomdepto])

            res.json({ message: 'Apartamento Creado' })
        } catch (error) {
            res.json({ message: "Fallo en la peticion" }).status(404)
            return
        }

    }



    static async UpdateDep(req: Request, res: Response): Promise<void> {
        const { id } = req.params
        let { nomdepto } = req.body

        if (nomdepto === "") {
            nomdepto = "Sin Data"
        }

        try {
            const result = await pool.query('UPDATE departamento SET nomdepto = $1 WHERE depto = $2 ', [nomdepto, id])
            res.json({ message: 'Apartamento Actualizado' })
        } catch (error) {
            res.json({ message: "Fallo en la peticion" })
            return
        }
    }


}

export default ControllGetApp
