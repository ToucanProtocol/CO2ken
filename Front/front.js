

let tokenPrice = $('get-token-price').val()/10^18;
$('field-token-price').val(`${tokenPrice} DAI`);

let tokenSupply = $('get-token-supply').val()/10^18;
$('field-supply-token').val(`${tokenSupply} CO2ken`);

let daiBalance = $('get-total-dai').val()/10^18;
$('field-DAI-amount').val(`${daiBalance} DAI`);

let gasFootprint = $('get-gas-footprint').val()/10^18;
$('field-co2-gas').val(`${gasFootprint} CO2ken`);

$('#field-token-price').onChange( () => {
    setTimeout( () => {
        $(this).css({'color': '#00f6aa', 'font-weight': '600'});
    }, 3000)
});

$('#field-supply-token').onChange( () => {
    setTimeout( () => {
        $(this).css({'color': '#00f6aa', 'font-weight': '600'});
    }, 3000)
});

$('#field-DAI-amount').onChange( () => {
    setTimeout( () => {
        $(this).css({'color': '#00f6aa', 'font-weight': '600'});
    }, 3000)
});

$('#field-co2-gas').onChange( () => {
    setTimeout( () => {
        $(this).css({'color': '#00f6aa', 'font-weight': '600'});
    }, 3000)
});
