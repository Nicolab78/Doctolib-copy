import 'dotenv/config';
import { PrismaClient } from '../../prisma/generated';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';

console.log('DATABASE_URL:', process.env.DATABASE_URL);

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);

const prisma = new PrismaClient({ adapter });

export default prisma;