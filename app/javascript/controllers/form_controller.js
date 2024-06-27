import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [
      'address',
      'purchase',
      'repair',
      'months',
      'arv',
      'personal',
      'next',
      'loadbar',
      'error'
    ];
  }

  connect (){
    this.loadbarTarget.style.width = `${100/6}%`
    document.addEventListener('keydown', (e) => {

      if (e.key == 'Enter'){
        this.goToNext(e);
      }
    })
  }

  goToNext(e) {
    e.preventDefault();
    e.stopPropagation();
    this.errorTarget.classList.add('hidden')

    const order = [
      this.addressTarget,
      this.monthsTarget,
      this.purchaseTarget,
      this.repairTarget,
      this.arvTarget,
      this.personalTarget
    ];

    let found = false;
    for(let i = 0; i < order.length; i++){
      if(found){
        order[i].classList.remove('hidden');
        this.loadbarTarget.style.width = `${(100 / 6) * (i + 1)}%`

        if(i == order.length - 1){
          this.nextTarget.classList.add('hidden')
        } else { this.nextTarget.classList.remove('hidden') }
        return;
      }

      if(!order[i].classList.contains('hidden')){
        found = true;
        if(order[i] == this.personalTarget){ return }
        let input = order[i].querySelectorAll('input')

        if (input.length == 1){
          if(input[0].value.trim() == ''){
            this.errorTarget.classList.remove('hidden')
            this.errorTarget.innerHTML = 'Please insert a value'
            return
          }
          if(input[0].name == 'loan[loan_term]' && (input[0].value >12 || input[0].value < 1)){
            this.errorTarget.classList.remove('hidden')
            this.errorTarget.innerHTML = 'Loan term must be between 1 and 12'
            return
          }
          if((input[0].name == 'loan[arv]' || input[0].name == 'loan[purchase_price]' || input[0].name == 'loan[repair_price]') && input[0].value < 1){
            this.errorTarget.classList.remove('hidden')
            this.errorTarget.innerHTML = 'Must be above 0'
            return
          }
        }
        order[i].classList.add('hidden');
      }
    }
  }

}
