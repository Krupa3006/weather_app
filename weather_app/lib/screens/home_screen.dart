import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_cubit.dart';

class HomeScreen extends StatelessWidget {
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      backgroundColor: const Color.fromARGB(255, 83, 155, 206),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text;
                context.read<WeatherCubit>().getWeather(city);
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state.isLoading) return CircularProgressIndicator();
                if (state.error != null) return Text('Error: ${state.error}');
                if (state.weather == null)
                  return Text(
                    'Enter a city to get weather',
                    style: TextStyle(color: Colors.white),
                  );

                final w = state.weather!;
                return Column(
                  children: [
                    Text(w.cityName, style: TextStyle(fontSize: 24)),
                    Text(
                      '${w.temperature.toStringAsFixed(1)} °C',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(w.description, style: TextStyle(fontSize: 18)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
