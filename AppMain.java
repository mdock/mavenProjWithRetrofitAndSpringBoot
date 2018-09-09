package com.company.webclient;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ubs.webclient.endpoints.HelloEndpoint;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.converter.jackson.JacksonConverterFactory;
import retrofit2.converter.scalars.ScalarsConverterFactory;

import java.io.IOException;

public class AppMain {
    public static void main(String[] args) throws IOException {
        Gson gson = new GsonBuilder()
                .setLenient()
                .create();

//        ObjectMapper mapper = new ObjectMapper();
//        mapper.setPropertyNamingStrategy(new PropertyNamingStrategy
//                                                 .PascalCaseStrategy());

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://localhost:8080")
                .addConverterFactory(ScalarsConverterFactory.create()) //it is needed for receiving simple string response, it must be first
                .addConverterFactory(GsonConverterFactory.create(gson))
                //.addConverterFactory(JacksonConverterFactory.create(mapper))
                .build();
        HelloEndpoint helloEndpoint = retrofit.create(HelloEndpoint.class);
        System.out.println((helloEndpoint.getHello()).execute().body().string());
        System.out.println(helloEndpoint.getPost("ala", "bbody").execute().code());
        System.out.println(helloEndpoint.getPost("ala", "bbody").request().url().encodedPath());
	// br1
    }
}
