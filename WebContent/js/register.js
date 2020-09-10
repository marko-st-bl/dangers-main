let pass1 = document.querySelector('#password1');
let pass2 = document.querySelector('#password2');
let result = document.querySelector('#passRes');

function checkPassword(){
    result.innerText = pass1.value == pass2.value ? 'Passwords matching' : 'Passwords not matching';
}

pass1.addEventListener('keyup', () => {
    if (pass2.value.length != 0) checkPassword();
})

pass2.addEventListener('keyup', checkPassword);