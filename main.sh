add_user()
{
    sudo adduser $USER

    if [ "$?" -ne "0" ]; 
    then
        echo "Falha ao adicionar usuário"
        return 1
    fi
    
    # sudo passwd $USER

    # if [ "$?" -ne "0" ]; 
    # then
    #     echo "Falha ao adicionar senha"
    #     return 1
    # fi

    return 0
}

add_group()
{
    sudo addgroup $GROUP

    if [ "$?" -ne "0" ]; 
    then
        echo "Falha ao adicionar grupo '$GROUP'"
        return 1
    fi

    return 0
}

remove_user()
{
    sudo userdel $USER

    if [ "$?" -ne "0" ]; 
    then
        echo "Falha ao remover '$USER'"
        return 1
    fi

    return 0
}

remove_group()
{
    sudo groupdel $GROUP

    if [ "$?" -ne "0" ]; 
    then
        echo "Falha ao remover '$GROUP'"
        return 1
    fi

    return 0
}

update_owner()
{
    sudo chown $USER $ARQ_NAME
    if [ "$?" -ne "0" ]; 
    then
        echo "Falha ao alterar '$ARQ_NAME'"
        return 1
    fi

    return 0
}

update_owner_group()
{
    sudo chgrp $GROUP $ARQ_NAME
    if [ "$?" -ne "0" ]; 
    then
        echo "Falha ao alterar '$ARQ_NAME'"
        return 1
    fi

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

        add_user
        RETURN_CODE=$?

        if [ $RETURN_CODE -eq 0 ]; then
            echo "Usuário '$USER' adicionado com sucesso!"
        else
            echo "Erro ao adicionar usuário '$USER'"
        fi
        ;;

    2)
        read -p "Insira um nome de grupo: " GROUP
        
        echo "Adicionando '$GROUP' ..."

        add_group
        RETURN_CODE=$?

        if [ $RETURN_CODE -eq 0 ]; then
            echo "Grupo '$GROUP' adicionado com sucesso!"
        else
            echo "Erro ao adicionar grupo '$GROUP'"
        fi
        ;;
    3)
        read -p "Insira o nome do usuário: " USER

        echo "Removendo '$USER' ..."

        remove_user
        RETURN_CODE=$?

        if [ $RETURN_CODE -eq 0 ]; then
            echo "Usuário '$USER' removido com sucesso!"
        else
            echo "Erro ao remover usuário '$USER'"
        fi
        ;;

    4)
        read -p "Insira o nome do grupo: " GROUP
        echo "Removendo '$GROUP' ... "

        remove_group
        RETURN_CODE=$?

        if [ $RETURN_CODE -eq 0 ]; then
            echo "Grupo '$GROUP' removido com sucesso!"
        else
            echo "Erro ao remover grupo '$GROUP'"
        fi
        ;;

    5)
        read -p "Insira o nome do novo dono: " USER
        read -p "Insira o nome do arquivo: " ARQ_NAME
        echo "Modificando o dono de '$ARQ_NAME' ..."

        update_owner
        RETURN_CODE=$?

        if [ $RETURN_CODE -eq 0 ]; then
            echo "Arquivo '$ARQ_NAME' alterado com sucesso!"
        else
            echo "Erro ao alterar arquivo '$ARQ_NAME'"
        fi
        ;;

    6)
        read -p "Insira o nome do novo grupo: " GROUP
        read -p "Insira o nome do arquivo: " ARQ_NAME
        echo "Modificando o dono de '$ARQ_NAME' ..."

        update_owner_group
        RETURN_CODE=$?

        if [ $RETURN_CODE -eq 0 ]; then
            echo "Arquivo '$ARQ_NAME' alterado com sucesso!"
        else
            echo "Erro ao alterar arquivo '$ARQ_NAME'"
        fi
        ;;
    *)
        echo "Opção inválida"
        ;;
esac

exit 1