import { pool } from "../db"

export async function validatePais(pais: string): Promise<string | undefined> {
    const result = await pool.query('SELECT * FROM pais WHERE pais = $1', [pais]);
    if (result.rows.length === 0) return undefined; // Devolver undefined si no se encuentra el país
    return result.rows[0].pais;
}

export async function validateDep(depto: string): Promise<string | undefined> {
    const result = await pool.query('SELECT * FROM departamento WHERE depto = $1', [depto]);
    if (result.rows.length === 0) return undefined; // Devolver undefined si no se encuentra el país
    return result.rows[0].depto;
}