declare -a ime=("Student1" "Student2")
declare -a prezime=("Prezime1" "Prezime2")
declare -a m_broj=("3333" "4444")
declare -a god_stud=("1" "1")
declare -a prosjek=("6" "10")



login(){
    lista=("user1,password1" "user2,password2")

    read -p "Unesite username: " username
    read -p "Unesite password" sifra

    tacna=false

    for user in "${lista[@]}";do
        IFS=',' read -r _username _sifra <<< "$user"
        if [ "$_username" == "$username" ] && [ "$_sifra" == "$sifra" ]; then
        tacna=true
        break
        else
        continue
        fi
        done
        if [ "$tacna" == false ]; then
        echo Netacna lozinka
        else
        echo Dobrodosli
        fi

}




admin_menu(){
    opcije=("Prikaz stud","Pretraga po imenu","Dodavanje studenata","Auziranje studenata","Brisanje studenata","Napusti program")
    IFS=','
    select opcija in ${opcije[@]}; do
        case $REPLY in
            1) 
                trebal=true
                show_all $trebal
            ;;
            2) searchByName
            ;;
            3) addStudent
            ;;
            4) updateStudent
            ;;
            5) deleteStudent
            ;;
            6) exit
            exit
            ;;
            *)
                echo Greska
            ;;
        esac
    done
}

show_all(){

local trebal=$1

for i in ${!ime[@]}; do


echo +-----------------+
echo "[$i]"
echo "|Ime->" ${ime[$i]}
echo "|Prezime->" ${prezime[$i]}
echo "|Godina studiranja->" ${god_stud[$i]}
echo "|Maticni Broj->" ${m_broj[$i]}
echo
done


if [ "$trebal" == true ]; then
admin_menu   
fi


}


addStudent(){
    clear
    read -p "Ime studenta: " _ime
    read -p "Prezime studenta: " _prezime
    read -p "Maticni broj: " _m_broj
    read -p "Godina studiranja: " _god_stud
    read -p "Prosjek: " _prosjek 

    ime+=($_ime)
    prezime+=($_prezime)
    m_broj+=($_m_broj)
    god_stud+=($_god_stud)
    prosjek+=($_prosje)



    admin_menu






}





searchByName(){

name_found=false

read -p "Unesite ime koje zelite naci: " _ime


 for i in "${!ime[@]}"; do

    

    if [ ${ime[$i]} == "$_ime" ]; then
    echo +-----------------+
    echo "[$i]"
    echo "|Ime->" ${ime[$i]}
    echo "|Prezime->" ${prezime[$i]}
    echo "|Godina studiranja->" ${god_stud[$i]}
    echo "|Maticni Broj->" ${m_broj[$i]}
    echo
    admin_menu






    name_found=true
    break

    else
     continue

    fi
 done
if [ "$name_found" = false ]; then
        echo "Ime nije pronadjeno"
        opcije=("Pokusaj ponovo" "Nazad na meni")
        
        select opcija in "${opcije[@]}"; do
        case $REPLY in 
        1) searchByName
        ;;
        2)admin_menu
        ;;
        *)
        echo Greska
        ;;
        esac
        done 


    fi




}






updateStudent(){
    clear
    trebal=false
    show_all $trebal
    

    read -p "Unesite index studenta kojeg zelite promijeniti: " _index

    zamjena=("Ime" "Prezime" "JMBG" "Godina" "Prosjek" "Sve")

    for i in "${!ime[@]}"; do

    if [ "$i" == "$_index" ]; then
    select izbor in "${zamjena[@]}"; do
    case $REPLY in 

    1)
      read -p "Uneiste novo ime studenta: " _ime
      ime[$i]=$_ime
      break
    ;;
     2)
      read -p "Uneiste novo prezime studenta: " _prezime
      prezime[$i]=$_prezime
      break
    ;;
    3)
      read -p "Uneiste novi JMBG studenta: " _m_broj
      m_broj[$i]=$_m_broj
      break

    ;;
    4)
      read -p "Uneiste novu god studiranja studenta: " _god_stud
      god_stud[$i]=$_god_stud
      break
    ;;
    5)
      read -p "Uneiste novi prosjek studenta: " _prosjek
      prosjek[$i]=$_prosjek
      break
    ;;
    6)
    read -p "Uneiste novo ime studenta: " _ime
    read -p "Uneiste novo prezime studenta: " _prezime
    read -p "Uneiste novi JMBG studenta: " _m_broj
    read -p "Uneiste novu god studiranja studenta: " _god_stud
    read -p "Uneiste novi JMBG studenta: " _prosjek
    ime[$i]=$_ime
    prezime[$i]=$_prezime
    m_broj[$i]=$_m_broj
    god_stud[$i]=$_god_stud
    prosjek[$i]=$_prosjek
    break




    ;;
    *)
    echo Nista
    break
    ;;
    esac
    done
    clear
    admin_menu
    else
    continue
    fi
    


    done









}


deleteStudent(){
    clear
    trebal=false
    show_all $trebal
    read -p "Uneiste index studenta kojeg zelite izbrisati " _index

    for i in "${!ime[@]}"; do

    if [ "$i" == "$_index" ]; then
    unset 'ime[$i]'
    unset 'prezime[$i]'
    unset 'm_broj[$i]'
    unset 'god_stud[$i]'
    unset 'prosjek[$i]'
    else
    continue
    fi



    done
    clear
    admin_menu






}






admin_menu
