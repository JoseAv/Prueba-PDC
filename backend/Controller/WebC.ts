import { Request, Response } from "express";
import { pool } from "../db"


class ControllerApiWeb {


    static async ShowPersona(_: Request, res: Response): Promise<void> {
        const result = await pool.query(`
             SELECT IdPersona, NombreCompleto, Direccion, NomPais, NomDepto
             FROM Persona JOIN Pais ON Persona.Pais = Pais.Pais 
             JOIN Departamento ON Persona.Departamento = Departamento.Depto AND Persona.Pais = Departamento.Pais
             `)
        res.json(result.rows)
    }

    static async ShowPais(_: Request, res: Response): Promise<void> {
        const result = await pool.query('SELECT * FROM pais')
        res.json(result.rows)
    }

    static async ShowDepartamento(_: Request, res: Response): Promise<void> {
        const result = await pool.query(`
            SELECT d.pais, d.depto, d.nomdepto 
            FROM Departamento d
            JOIN Pais p ON d.pais = p.pais
        `);
        res.json(result.rows)
    }



}

export default ControllerApiWeb