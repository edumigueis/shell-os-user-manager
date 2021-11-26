add_user()
{
    sudo adduser $USER

    if ["$?" -ne "0"]; 
    then
        echo "Falha ao adicionar um usuário '$USER'"
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

    if ["$?" -ne "0"]; 
    then
        echo "Falha ao adicionar um novo grupo '$GROUP'"
        return 1
    fi

    return 0
}

remove_user()
{
    sudo userdel $USER

    if ["$?" -ne "0"]; 
    then
        echo "Falha ao remover '$USER'"
        return 1
    fi

    return 0
}

remove_group()
{
    sudo groupdel $GROUP

    if ["$?" -ne "0"]; 
    then
        echo "Falha ao remover '$GROUP'"
        return 1
    fi

    return 0
}

update_owner()
{
    sudo chown $USER $ARQ_NAME
    if ["$?" -ne "0"]; 
    then
        echo "Falha ao alterar '$ARQ_NAME'"
        return 1
    fi

    return 0
}

update_owner_group()
{
    sudo chgrp $GROUP $ARQ_NAME
    if ["$?" -ne "0"]; 
    then
        echo "Falha ao alterar '$ARQ_NAME'"
        return 1
    fi

    return 0
}

update_file_dir_permissions()
{

    case $PERM_TARGET_OPTION in
        1)
            case $PERM_TARGET_OPTION in
                1) 
                    sudo chmod u-rwx $ARQ_NAME
                    if ["$?" -ne "0"]; 
                    then
                        echo "Erro ao alterar permissiões. Código de permissões inválido"
                        return 1
                    fi
                    ;;
                2)
                    sudo chmod u+w $ARQ_NAME
                    if ["$?" -ne "0"]; 
                    then
                        echo "Erro ao alterar permissiões. Código de permissões inválido"
                        return 1
                    fi
                    ;;
                3)
                    sudo chmod u+r $ARQ_NAME
                    if ["$?" -ne "0"]; 
                    then
                        echo "Erro ao alterar permissiões. Código de permissões inválido"
                        return 1
                    fi
                    ;;
                4)
                    sudo chmod u+x $ARQ_NAME
                    if ["$?" -ne "0"]; 
                    then
                        echo "Erro ao alterar permissiões. Código de permissões inválido"
                        return 1
                    fi
                    ;;
                *)
                    echo "Erro ao alterar permissiões. Código de permissões inválido"
                    return 1
            esac

            return 0
            ;;
        2) 
            TARGET = "g"
            ;;
        3)
            TARGET = "o"
            ;;
        *) 
            echo "Opção inválida"
            ;;
    esac

    if ["$?" -ne "0"]; 
    then
        echo "Falha ao alterar '$ARQ_NAME'"
        return 1
    fi

    return 0
}

# Parte principal do código

echo " ****************************** "
echo "              Menu              "
echo " ****************************** "
echo "1. Adicionar novo usuário"
echo "2. Adicionar novo grupo"
echo "3. Remover usuário"
echo "4. Remover grupo"
echo "5. Modificar o dono de um arquivo ou diretório"
echo "6. Modificar o grupo de um arquivo ou diretório"
echo "7. Alterar permissões de um arquivo ou diretório"

read -p "Escolha uma das opção: " OPTION

case $OPTION in
    1)
        read -p "Insira um nome do usuário: " USER
        
        echo "Adicionando novo usuário '$USER'..."

        add_user
        RETURN_CODE=$?

        if [$RETURN_CODE -eq 0]; 
        then
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

        if [$RETURN_CODE -eq 0]; 
        then
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

        if [$RETURN_CODE -eq 0]; 
        then
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

        if [$RETURN_CODE -eq 0]; 
        then
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

        if [$RETURN_CODE -eq 0]; 
        then
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

        if [$RETURN_CODE -eq 0]; 
        then
            echo "Arquivo '$ARQ_NAME' alterado com sucesso!"
        else
            echo "Erro ao alterar arquivo '$ARQ_NAME'"
        fi
        ;;
    7)
        read -p "Insira o nome do arquivo: " ARQ_NAME
        
        echo "Deseja alterar a permissão para: "
        echo "1. Nenhuma"
        echo "2. Escrita"
        echo "3. Leitura"
        echo "4. Execução"
        read -p "Insira o código da permissão: " PERM_TYPE_OPTION
        
        echo "Deseja alterar as permissões do:"
        echo "1. Dono do arquivo"
        echo "2. Grupo do arquivo"
        echo "3. Outros"
        read -p "Insira o código do alvo: " PERM_TARGET_OPTION
        
        update_file_dir_permissions
        RETURN_CODE=$?
        
        if ["$RETURN_CODE" -eq 0]; 
        then
            echo "Permissões do arquivo '$ARQ_NAME' alteradas com sucesso!"
        else
            echo "Erro ao alterar permissões do arquivo '$ARQ_NAME'"
        fi
        ;;

    *)
        echo "Opção inválida"
        ;;
esac

exit 1
