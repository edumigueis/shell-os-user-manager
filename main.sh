add_user()
{
    return 0
}

add_group()
{
    return 0
}

remove_user()
{
    return 0
}

remove_group()
{
    return 0
}

update_user()
{
    return 0
}

update_group()
{
    return 0
}

# Parte principal do código

echo " ------------ Menu ------------ "
echo "1 - Adicionar novo usuário"
echo "2 - Adicionar novo grupo"
echo "3 - Remover usuário"
echo "4 - Remover grupo"
echo "5 - Modificar o dono de um arquivo ou diretório"
echo "6 - Modificar o grupo dono de um arquivo ou diretório"

read -p "Escolha a opção: " OPTION

case $OPTION in
    1)
        read -p "Insira um nome do usuário: " USER
        
        echo "Adicionando '$USER' ..."
        ;;

    2)
        read -p "Insira um nome de grupo: " GROUP
        
        echo "Adicionando '$GROUP' ..."
        ;;
    3)
        read -p "Insira o nome do usuário: " USER

        echo "Removendo $USER ..."
        ;;

    4)
        read -p "Insira o nome do grupo: " GROUP
        echo "Removendo $GROUP ... "
        ;;

    5)
        read -p "Insira o nome do usúario: " USER
        read -p "Insira o nome do arquivo: " ARQ_NAME
        echo "Modificando o dono de $ARQ_NAME ..."
        ;;

    6)
        read -p "Insira o nome do grupo: " GROUP
        read -p "Insira o nome do arquivo: " ARQ_NAME
        echo "Modificando o grupo dono de $ARQ_NAME ..."
        ;;
    *)
        echo "Opção inválida"
        ;;
esac

exit 1