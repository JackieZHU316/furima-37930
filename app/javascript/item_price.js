function price_input (){
  const PriceInput  = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const Profit = document.getElementById("profit");

  PriceInput.addEventListener("keyup", () => {
    addTaxDom.innerHTML = Math.floor(PriceInput.value * 0.1);
    Profit.innerHTML = Math.floor(PriceInput.value - addTaxDom.innerHTML);
  });

};

window.addEventListener('load', price_input);




