import React, { useState } from 'react';
import { StyleSheet, Text, View, FlatList, TextInput } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';

const tarotCards = [
  { id: '1', name: 'Шут', meaning: 'Новые начинания, спонтанность, свобода.' },
  { id: '2', name: 'Маг', meaning: 'Сила воли, возможности, творчество.' },
  { id: '3', name: 'Верховная Жрица', meaning: 'Интуиция, тайны, духовное знание.' },
  // Здесь можно добавить все карты из PDF
];

export default function App() {
  const [search, setSearch] = useState('');
  const filteredCards = tarotCards.filter(card =>
    card.name.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <LinearGradient colors={['#8e2de2', '#000000', '#ff0080']} style={styles.container}>
      <Text style={styles.title}>🔮 Таро Гид</Text>
      <TextInput
        style={styles.input}
        placeholder="Поиск карты..."
        placeholderTextColor="#ccc"
        value={search}
        onChangeText={setSearch}
      />
      <FlatList
        data={filteredCards}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <View style={styles.card}>
            <Text style={styles.cardName}>{item.name}</Text>
            <Text style={styles.cardMeaning}>{item.meaning}</Text>
          </View>
        )}
      />
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, padding: 20, paddingTop: 60 },
  title: { fontSize: 28, fontWeight: 'bold', color: 'white', marginBottom: 20, textAlign: 'center' },
  input: { backgroundColor: '#222', color: 'white', padding: 10, borderRadius: 10, marginBottom: 20 },
  card: { backgroundColor: 'rgba(0,0,0,0.6)', padding: 15, borderRadius: 12, marginBottom: 10 },
  cardName: { fontSize: 20, color: '#ff99cc', fontWeight: 'bold' },
  cardMeaning: { fontSize: 16, color: 'white', marginTop: 5 },
});
