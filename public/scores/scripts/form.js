/**
 * Created by Sam_Brown on 18.07.16.
 */

function pruefen()
{
    result = true;
    form = document.form2;

    if(form.Name.value == ''){
        result = false;}
    if(form.Address.value == ''){
        result = false;}
    if(form.Mail.value == ''){
        result = false;}
    if(form.Input.value == ''){
        result = false;}
    if(form.Mail.value.indexOf('@') == -1){
        result = false;}
    if(form.Mail.value.length < 8){
        result = false;}

    if(form.News[0].checked == false && form.News[1].checked == false)
    {result = false;}

    if(form.Betreff.selectedIndex == 0){result = false;}

    if(result == false){alert('Bitte überprüfe deine Eingaben!')}
    return result;
}