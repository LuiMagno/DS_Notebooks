# Libraries
import re
from haversine import haversine
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import streamlit as st
from PIL import Image
import folium
from streamlit_folium import folium_static
# Dataset
df_root = pd.read_csv('C:/Users/lui-m/Documents/GitHub/DS_Notebooks/ComunidadeDS/FTC_Python/datasets/train.csv')

# Fazendo cópia do dataframe lido
df = df_root.copy()

# Convertendo colunas e retirando valores NaN
linhas_selecionadas = (df['Delivery_person_Age'] != 'NaN ')
df = df.loc[linhas_selecionadas, :].copy()

linhas_selecionadas = (df['Road_traffic_density'] != 'NaN ')
df = df.loc[linhas_selecionadas, :].copy()

linhas_selecionadas = (df['City'] != 'NaN ')
df = df.loc[linhas_selecionadas, :].copy()

linhas_selecionadas = (df['Festival'] != 'NaN ')
df = df.loc[linhas_selecionadas, :].copy()

df['Delivery_person_Age'] = df['Delivery_person_Age'].astype( int )

# Convertendo a coluna ratings de texto para numero decimal (float)
df['Delivery_person_Ratings'] = df['Delivery_person_Ratings'].astype( float )

# Convertendo a coluna order date de texto para data
df['Order_Date'] = pd.to_datetime(df['Order_Date'], format='%d-%m-%Y')

# Convertendo multiple_deliveries de textopara numero inteiro (int)
linhas_selecionadas = (df['multiple_deliveries'] != 'NaN ')
df = df.loc[linhas_selecionadas, :].copy()
df['multiple_deliveries'] = df['multiple_deliveries'].astype( int )

# Removendo os espaços dentro de string/texto/objeto
df.loc[:, 'ID'] = df.loc[:, 'ID'].str.strip()
df.loc[:, 'Road_traffic_density'] = df.loc[:, 'Road_traffic_density'].str.strip()
df.loc[:, 'Type_of_order'] = df.loc[:, 'Type_of_order'].str.strip()
df.loc[:, 'Type_of_vehicle'] = df.loc[:, 'Type_of_vehicle'].str.strip()
df.loc[:, 'City'] = df.loc[:, 'City'].str.strip()
df.loc[:, 'Festival'] = df.loc[:, 'Festival'].str.strip()

# Limpando a Coluna de time taken
df['Time_taken(min)'] = df['Time_taken(min)'].apply( lambda x: x.split( '(min)' )[1])
df['Time_taken(min)'] = df['Time_taken(min)'].astype( int )


# Visão da Empresa

#====================================================
# Barra Lateral
#====================================================


image_path = 'eu.png'
image = Image.open(image_path)

st.sidebar.image(image, width = 120)
st.sidebar.markdown('# Curry Company')
st.sidebar.markdown('# Fastest Delivery in Town')
st.sidebar.markdown("""---""")

st.sidebar.markdown('## Selecione uma data limite')

date_slider = st.sidebar.slider('Até qual valor?', value=pd.datetime(2022, 4 , 13),
                 min_value=pd.datetime(2022, 2 , 11),
                 max_value=pd.datetime(2022, 4, 6),
                 format='DD-MM-YYYY')
#st.metric(label="Data", value=date_slider)


st.sidebar.markdown("""---""")

traffic_options = st.sidebar.multiselect('Quais as condições de trânsito?',
                      ['Low', 'Medium', 'High', 'Jam'],
                      default = 'Low')
st.sidebar.markdown("""---""")
st.sidebar.markdown('Powerd by Comunidade DS')

# Filtro de Data
linhas_selecionadas = df['Order_Date'] < date_slider
df = df.loc[linhas_selecionadas, :]

# Filtro de transito
linhas_selecionadas = df['Road_traffic_density'].isin(traffic_options)
df = df.loc[linhas_selecionadas, :]
#====================================================
# Layout no Streamlit
#====================================================
st.header('Marketplace - Visão Cliente')


# Criando tabs
tab1, tab2, tab3 = st.tabs(['Visão Gerencial', 'Visão Tática', 'Visão Geográfica'])

with tab1:
    with st.container():
        # Order metric
        # 1. Qual a quantidade de pedidos por dia?
        st.markdown('# Orders by Day')
        # colunas
        cols = ['ID', 'Order_Date']

        df_pedidos_dia = df.loc[:, cols].groupby(['Order_Date']).count().reset_index()
        df_pedidos_dia.head()

        # Desenhar o gráfico de linhas
        # Plotly
        fig = px.bar(df_pedidos_dia, x = 'Order_Date', y = 'ID')
        st.plotly_chart(fig, use_container_width = True)
    
    
    # Segunda linha
    with st.container():
        col1, col2 = st.columns(2)
        with col1:
            st.markdown('# Traffic Order Share')
            cols = ['ID', 'Road_traffic_density']

            df_pedidos_trafego = df.loc[:, cols].groupby(['Road_traffic_density']).count().reset_index()

            # Removendo valores NaN
            df_pedidos_trafego = df_pedidos_trafego.loc[df_pedidos_trafego['Road_traffic_density'] != 'NaN', :]

            df_pedidos_trafego['entregas_perc'] = df_pedidos_trafego['ID'] / df_pedidos_trafego['ID'].sum()

            fig = px.pie(df_pedidos_trafego, values='entregas_perc', names='Road_traffic_density')
            st.plotly_chart(fig, use_container_width = True)
        with col2:
            st.markdown('# Traffic Order City')
            df_aux = df.loc[:, ['ID', 'City', 'Road_traffic_density']].groupby(['City', 'Road_traffic_density']).count().reset_index()

            # Removendo valores NaN

            df_aux = df_aux.loc[df_aux['City'] != 'NaN ', :]
            df_aux = df_aux.loc[df_aux['Road_traffic_density'] != 'NaN ', :]

            # Fazendo um gráfico de bolhas

            fig = px.scatter(df_aux, x = 'City', y = 'Road_traffic_density', size='ID', color='City')
            st.plotly_chart(fig, use_container_width = True)
           
with tab2: 
    with st.container():
        st.markdown('# Order By Week')
        # criar a coluna semana
        df['week_of_year'] = df['Order_Date'].dt.strftime('%U')

        # Groupby de entregas por semana
        cols = ['ID', 'week_of_year']

        df_pedidos_semana = df.loc[:, cols].groupby(['week_of_year']).count().reset_index()

        # Desenhando o gráfico
        fig = px.line(df_pedidos_semana, x = 'week_of_year', y = 'ID')
        st.plotly_chart(fig, use_container_width = True)
    with st.container():
        st.markdown('# Order By Week per Delivery Person')
        # Quantidade de pedidos dividos pelo número único de entregadores por semana
        df_aux01 = df.loc[:, ['ID', 'week_of_year']].groupby(['week_of_year']).count().reset_index()
        df_aux02 = df.loc[:, ['Delivery_person_ID', 'week_of_year']].groupby(['week_of_year']).nunique().reset_index()

        # Juntar 2 dataframes
        df_aux = pd.merge(df_aux01, df_aux02, how='inner')
        df_aux['order_by_deliver'] = df_aux['ID'] / df_aux['Delivery_person_ID'] 

        fig = px.line(df_aux, x = 'week_of_year', y='order_by_deliver')
        st.plotly_chart(fig, use_container_width = True)
with tab3:
    st.markdown('# Country Maps')
    
    df_aux = df.loc[:, ['City', 'Road_traffic_density', 'Delivery_location_latitude', 'Delivery_location_longitude']].groupby(['City','Road_traffic_density']).median().reset_index()

    # Limpandos NaN
    df_aux = df_aux.loc[df_aux['City'] != 'NaN ', :]
    df_aux = df_aux.loc[df_aux['Road_traffic_density'] != 'NaN', :]

    map = folium.Map()
    for index, location_info in df_aux.iterrows():
        folium.Marker([location_info['Delivery_location_latitude'],
                      location_info['Delivery_location_longitude']],
                      popup=location_info[['City', 'Road_traffic_density']]).add_to(map)
    folium_static(map, width=1024, height=600)