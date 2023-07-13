# Libraries
import re
from haversine import haversine
import pandas as pd
import numpy as np
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
                      default = ['Low', 'Medium', 'High', 'Jam'])
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
st.header('Marketplace - Visão Restaurantes')

tab1, tab2, tab3 = st.tabs(['Visão Gerencial', '_', '_'])

with tab1:
    with st.container():
        st.title('Overall Metrics')
        
        col1, col2, col3, col4, col5, col6 = st.columns(6)
        with col1:
            entregadores_unicos = df['Delivery_person_ID'].nunique()
            col1.metric(value = entregadores_unicos, label = "Entregadores Únicos")
            
        with col2:
            cols = ['Restaurant_latitude', 'Restaurant_longitude', 'Delivery_location_latitude', 'Delivery_location_longitude']
            df['distance'] = df.loc[:, cols].apply( lambda x: haversine((x['Restaurant_latitude'], x['Restaurant_longitude']),
                                                            (x['Delivery_location_latitude'], x['Delivery_location_longitude'])), axis = 1)
            distancia_media = np.round(df['distance'].mean(), 2)
            col2.metric(value = distancia_media, label = "Distância Média")
            
        with col3:
            df_aux = (df.loc[:, ['Time_taken(min)', 'Festival']]
                       .groupby(['Festival'])
                       .agg({'Time_taken(min)': ['mean', 'std']}))
                    
            df_aux.columns = ['avg_time', 'std_time']
            df_aux = df_aux.reset_index()
            #print(f'O tempo médio de entregas durante os festivais foi de: {tempo_medio_festival}')
            df_aux = np.round(df_aux.loc[df_aux['Festival'] == 'Yes', 'avg_time'], 2)

            col3.metric('Tempo Médio de Entrega - Festival', df_aux)
            
        with col4:
            df_aux = (df.loc[:, ['Time_taken(min)', 'Festival']]
                       .groupby(['Festival'])
                       .agg({'Time_taken(min)': ['mean', 'std']}))
                    
            df_aux.columns = ['avg_time', 'std_time']
            df_aux = df_aux.reset_index()
            #print(f'O tempo médio de entregas durante os festivais foi de: {tempo_medio_festival}')
            df_aux = np.round(df_aux.loc[df_aux['Festival'] == 'Yes', 'std_time'], 2)

            col4.metric('Desvio Padrão de Entrega - Festival', df_aux)
            
        with col5:
            df_aux = (df.loc[:, ['Time_taken(min)', 'Festival']]
                       .groupby(['Festival'])
                       .agg({'Time_taken(min)': ['mean', 'std']}))
                    
            df_aux.columns = ['avg_time', 'std_time']
            df_aux = df_aux.reset_index()
            #print(f'O tempo médio de entregas durante os festivais foi de: {tempo_medio_festival}')
            df_aux = np.round(df_aux.loc[df_aux['Festival'] == 'No', 'avg_time'], 2)

            col5.metric('Tempo Médio de Entrega - Festival', df_aux)
        with col6:
            df_aux = (df.loc[:, ['Time_taken(min)', 'Festival']]
                       .groupby(['Festival'])
                       .agg({'Time_taken(min)': ['mean', 'std']}))
                    
            df_aux.columns = ['avg_time', 'std_time']
            df_aux = df_aux.reset_index()
            #print(f'O tempo médio de entregas durante os festivais foi de: {tempo_medio_festival}')
            df_aux = np.round(df_aux.loc[df_aux['Festival'] == 'No', 'std_time'], 2)

            col6.metric('Desvio Padrão de Entrega - Festival', df_aux)
            
        st.markdown("""---""")
        
    with st.container():
        col1, col2 = st.columns(2)
        
        with col1:
            df_aux = df.loc[:, ['Time_taken(min)', 'City']].groupby('City').agg({'Time_taken(min)': ['mean', 'std'] })

            df_aux.columns = ['avg_time', 'std_time']

            df_aux = df_aux.reset_index()

            fig = go.Figure()
            fig.add_trace(go.Bar(name = 'Control', x=df_aux['City'], y=df_aux['avg_time'], error_y=dict(type='data', array=df_aux['std_time'])))
            fig.update_layout(barmode='group')

            st.plotly_chart(fig)
        
        with col2: 
            df_aux = df.loc[:, ['Time_taken(min)', 'City', 'Type_of_order']].groupby(['City', 'Type_of_order']).agg({'Time_taken(min)': ['mean', 'std'] })

            df_aux.columns = ['avg_time', 'std_time']

            df_aux = df_aux.reset_index()
            st.dataframe(df_aux)

            
        st.markdown("""---""")
        
    with st.container():
        col1, col2 = st.columns(2)
        
        with col1:
            st.title('')
            cols = ['Restaurant_latitude', 'Restaurant_longitude', 'Delivery_location_latitude', 'Delivery_location_longitude']
            df['distance'] = df.loc[:, cols].apply( lambda x: haversine((x['Restaurant_latitude'], x['Restaurant_longitude']),
                                                                        (x['Delivery_location_latitude'], x['Delivery_location_longitude'])), axis = 1)
            avg_distance = df.loc[:, ['City', 'distance']].groupby('City').mean().reset_index()

            fig = go.Figure(data= [go.Pie(labels=avg_distance['City'], values=avg_distance['distance'], pull=[0, 0.1, 0])])
            st.plotly_chart(fig)
            
        with col2:
            df_aux = df.loc[:, ['Time_taken(min)', 'City', 'Road_traffic_density']].groupby(['City', 'Road_traffic_density']).agg({'Time_taken(min)': ['mean', 'std'] })

            df_aux.columns = ['avg_time', 'std_time']

            df_aux = df_aux.reset_index()
            
            fig = px.sunburst(df_aux, path=['City', 'Road_traffic_density'], values='avg_time',
                             color='std_time', color_continuous_scale='RdBu',
                             color_continuous_midpoint=np.average(df_aux['std_time']))
            st.plotly_chart(fig)
            
        st.markdown("""---""")
        