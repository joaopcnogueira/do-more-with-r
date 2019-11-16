# Lookup vectors works similar to Python Dictionary.
# Names <--> Keys
# Value <--> Value
#
# lookup = {'Ceará': 'CE'}      : Python
# lookup <- c("Ceará" = "CE")   : R
#


library(tidyverse)

brazil_states <- data.frame(estado = c("Acre", "Alagoas", "Amapá",
                                       "Amazonas", "Bahia", "Ceará",
                                       "Distrito Federal", "Espírito Santo", "Goiás",
                                       "Maranhão", "Mato Grosso",
                                       "Mato Grosso do Sul", "Minas Gerais", "Pará",
                                       "Paraíba", "Paraná", "Pernambuco", "Piauí",
                                       "Rio de Janeiro",
                                       "Rio Grande do Norte", "Rio Grande do Sul", "Rondônia",
                                       "Roraima", "Santa Catarina", "São Paulo",
                                       "Sergipe", "Tocantins"),
                            sigla = c("AC", "AL", "AP", "AM", "BA", "CE",
                                      "DF", "ES", "GO", "MA", "MT", "MS",
                                      "MG", "PA", "PB", "PR", "PE", "PI",
                                      "RJ", "RN", "RS", "RO", "RR", "SC", "SP",
                                      "SE", "TO"),
                            capital = c("Rio Branco", "Maceió", "Macapá",
                                        "Manaus", "Salvador", "Fortaleza",
                                        "Brasília", "Vitória", "Goiânia",
                                        "São Luís", "Cuiabá", "Campo Grande",
                                        "Belo Horizonte", "Belém", "João Pessoa",
                                        "Curitiba", "Recife", "Teresina",
                                        "Rio de Janeiro", "Natal", "Porto Alegre",
                                        "Porto Velho", "Boa Vista", "Florianópolis",
                                        "São Paulo", "Aracaju", "Palmas"), 
                            stringsAsFactors=FALSE)


brazil_states %>% head()

# Named vector in R can work as lookup tables (similar to dict in python)
get_postal_code <- brazil_states$sigla
names(get_postal_code) <- brazil_states$estado

# Accessing the value in the Ceará key
get_postal_code['Ceará']

# If we just wanna the value
get_postal_code['Ceará'] %>% unname()

# Function to encapsulate unname()
get_value <- function(lookupvector, key) {
    unname(lookupvector[key])
}

get_postal_code %>% get_value('Ceará')
get_value(get_postal_code, 'Ceará')


# Replacing values with the lookup vector
estados_sem_sigla <- c('Acre', 'Alagoas', 'Amapá', 'Amazonas')
estados_sem_sigla

# Filter the lookup vector by the vector you want to rename
estados_com_sigla <- get_postal_code[estados_sem_sigla]

estados_com_sigla
estados_com_sigla %>% unname()

tbl <- tibble(estados = estados_sem_sigla)
tbl

tbl %>% 
    mutate(sigla = get_postal_code[estados_sem_sigla])
