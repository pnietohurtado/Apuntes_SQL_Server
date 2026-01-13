import {getConnection} from "../connectionMongo/connectionMongoDB.js"; 
// import {v4} from "uuid";  I think I need to make some changes inside of the project in order 
// to use this library 

const getLanguage = async () => {
    try{
        const database = await getConnection(); 
        const languages = await database.collection("languages").find().toArray(); 
        
        console.table(languages); 
        console.log("Languages listed!"); 
    }catch(error){
        console.error(error); 
    }
}

const addLanguage = async() => {
    try{

        const database = await getConnection(); 
        const result = await database.collection("languages").insertOne({_id:"ajolote20002222" ,Name: 'Panchito' , Difficulty: '10/10'}); 
        console.log(result); 
        console.log("Language added!"); 

    }catch(error){
        console.error(error); 
    }
}

addLanguage(); 
getLanguage(); 