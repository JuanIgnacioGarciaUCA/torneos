function enviarABaseDeDatos(kt, ij, nj) {
    fetch('https://sheetdb.io/api/v1/u7f61imgbw9qb', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            data: [{ "key_torneo": kt, "numero_jugador": ij, "nombre_jugador": nj }]
        })
    })
    .then(response => response.json())
    .then(data => alert('Datos guardados correctamente'));
}

async function buscarDatos(columna, valor) {
    const url = `https://sheetdb.io/api/v1/u7f61imgbw9qb/search?${columna}=${valor}`;
    
    try {
        const respuesta = await fetch(url);
        const resultados = await respuesta.json();
        
        if (resultados.length > 0) {
            console.log("Datos encontrados:", resultados);
            // resultados es un array, el primero sería resultados[0]
            alert("Encontrado: " + resultados[0].datos);
        } else {
            console.log("No se encontraron coincidencias");
        }
    } catch (error) {
        console.error("Error al buscar:", error);
    }
}

