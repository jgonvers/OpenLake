import places from 'places.js';

const initAutocomplete = () => {
  //console.log(document.querySelector('#flat_address'));
  const addressInput = document.getElementById('event_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };