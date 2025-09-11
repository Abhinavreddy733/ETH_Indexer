import { prismaClient } from "db";
import express from "express"

const app = express();
const PORT = 3000 | 3001

app.use(express.json());

app.post("/deposit" , async (req , res) => {
    const address = req.body.address;
    const amount = req.body.amount;

    const resData = await prismaClient.transactionPending.create({
        data:{
            address,
            amount,
            type:"DEPOSIT"
        }
    })
   
    res.json({
        message:"user added to deposit pending list"
    })
})

app.post("/signup" , async (req , res) => {
    const email = req.body.email;
    
})

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});