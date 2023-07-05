import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

admin.initializeApp();
export const UpdateAniversarios = functions.firestore
    .document("encontrista/{encontristaId}")
    .onUpdate((change, context) => {
        const dado = change.after.data();
        let datanascimento = dado.esposa.nascimento.toDate();
        admin.firestore().collection("aniversarios")
            .doc(context.params.encontristaId + "_esposa")
            .set({
                nome: dado.esposa.nome,
                tipo: "Esposa",
                data: datanascimento,
                dia: datanascimento.getDate(),
                diaSemana: datanascimento.getDay(),
                mes: datanascimento.getMonth(),
                detalhes: " do " + dado.marido.nome,
            });
        datanascimento = dado.marido.nascimento.toDate();
        admin.firestore().collection("aniversarios")
            .doc(context.params.encontristaId + "_esposo")
            .set({
                nome: dado.marido.nome,
                tipo: "Marido",
                data: datanascimento,
                dia: datanascimento.getDate(),
                diaSemana: datanascimento.getDay(),
                mes: datanascimento.getMonth(),
                detalhes: " da " + dado.esposa.nome,
            });
        datanascimento = dado.casamento.data.toDate();
        let nome = dado.esposa.nome.split(" ")[0];
        nome += " e " + dado.marido.nome.split(" ")[0];

        const dataFinal = new Date();
        const diffInMilliseconds =
            Math.abs(dataFinal.getTime() - datanascimento.getTime());
        const umDiaEmMilissegundos = 24 * 60 * 60 * 1000;
        const umAnoEmMilissegundos = 365 * umDiaEmMilissegundos;
        const anos = Math.floor(diffInMilliseconds / umAnoEmMilissegundos);
        const meses = Math.floor(diffInMilliseconds % umAnoEmMilissegundos / (30 * umDiaEmMilissegundos));
        const dias = Math.floor(diffInMilliseconds % umAnoEmMilissegundos % (30 * umDiaEmMilissegundos) / umDiaEmMilissegundos);
        const diferencaString = `${anos} anos, ${meses} meses e ${dias} dias`;

        admin.firestore().collection("aniversarios")
            .doc(context.params.encontristaId + "_casamento")
            .set({
                nome: nome,
                tipo: "Casamento",
                data: datanascimento,
                dia: datanascimento.getDate(),
                diaSemana: datanascimento.getDay(),
                mes: datanascimento.getMonth(),
                detalhes: diferencaString,
            });
        console.log("DADOS DOS FILHOS", dado.filhos);
        for (let i = 0; i < dado.filhos.length; i++) {
            const element = dado.filhos[i];
            if (element.nome.trim() != "") {
                let nome = dado.esposa.nome.split(" ")[0];
                nome += " e " + dado.marido.nome.split(" ")[0];
                datanascimento = element.data_nascimento.toDate();
                admin.firestore().collection("aniversarios")
                    .doc(context.params.encontristaId + "_filho_" + i.toString())
                    .set({
                        nome: element.nome,
                        tipo: "Filho",
                        data: datanascimento,
                        dia: datanascimento.getDate(),
                        diaSemana: datanascimento.getDay(),
                        mes: datanascimento.getMonth(),
                        detalhes: nome,
                    });
                console.log(element);
            }
        }
        return null;
    });
