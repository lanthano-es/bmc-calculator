# COURSE: Developing Data Products by Johns Hopkins University
# Peer-graded Assignment: Course Project: Shiny Application and Reproducible Pitch
# Author: Francisco González Alonso
# Date: 2016/09/25
# Comments: Web app in shiny for Course Project of Developing Data Products 
# course.

# This is the server logic for my BMI-Calculator Shiny web application.

library(shiny)

shinyServer(
  
  function(input, output) {
    
    # Global Scope to session
    # Calculate all BMC levels per height to mostrate in a plot
    df.IMC<-data.frame(
      height=c(20:250),
      bmc1=18.5 * ((c(20:250)/100)^2),
      bmc2=25 * ((c(20:250)/100)^2),
      bmc3=30 * ((c(20:250)/100)^2),
      bmc4=35 * ((c(20:250)/100)^2),
      bmc5=40 * ((c(20:250)/100)^2),
      bmc6=50 * ((c(20:250)/100)^2)
    );
    
    # Assign the colors to mostrate in the plot the several BMC levels        
    colours<-c("blue","black","orange", "red", "brown", "purple");
    
    # Assign the colors to mostrate in the plot the several BMC levels
    msgLegend<-c("Underweight", "Normal weight",
                 "Overweight", "Obese type I","Obese type II",
                 "Obese type III");
    
    # Show the wellcome text and include the user name of proactive form.
    output$textOutputName <- renderText(
      {
        msg<- paste0("Hello ",input$name);
        msg<- paste0(msg," you must enter your name, weight and height, and 
                     then click on the Calculate button and have 
                     fun (or cry).");
        msg
      }
        );
    
    # Calculate and show the BMC data.
    output$textOutputIMC <- renderText(
      {
        input$goButton;
        if(input$goButton==0) msg<-"" 
        else{
          isolate(
            {
              imc<-(round(input$weight/((input$height/100)^2),4));
              paste0("Your BMC is: ",imc)
            }
          )
        }
      }
    );
    
    # Calculate and show the BMC level.
    output$textOutputMSG <- renderText(
      {
        input$goButton;
        if(input$goButton==0) msg<-""
        else{
          isolate( 
            {
              msg<- "You have ";
              imc<-(round(input$weight/((input$height/100)^2),4));
              if(imc<18.5) msg<-paste0(msg, "underweight.");
              if(imc>=18.5&&imc<25) msg<-paste0(msg, "a normal weight.");
              if(imc>=25&&imc<30) msg<-paste0(msg, "overweight.");
              if(imc>=30&&imc<35) msg<-paste0(msg, "obese type I.");
              if(imc>=35&&imc<40) msg<-paste0(msg, "obese type II.");
              if(imc>=40&&imc<50) msg<-paste0(msg, "obese type III.");
              if(imc>=50) msg<-paste0(msg, "obese type IV.");
              msg;
            }
          )
        }
      } 
    );
    
    # Calculate and show the BMC levels vs BMC/user plot.
    output$BMCPlot <- renderPlot(
      {
        input$goButton
        if(input$goButton!=0){
          isolate(
            {
              
              plot(df.IMC$bmc1, df.IMC$height, 
                   type="l",
                   col=colours[1],
                   main="BMC LEVELS",
                   ylab="Height (Cm.)",
                   xlab="Weight (kgrs.)",
                   ylim=c(0,250),
                   xlim=c(0,150)
              );
              
              lines(df.IMC$bmc2, df.IMC$height, col=colours[2]);
              lines(df.IMC$bmc3, df.IMC$height, col=colours[3]);
              lines(df.IMC$bmc4, df.IMC$height, col=colours[4]);
              lines(df.IMC$bmc5, df.IMC$height, col=colours[5]);
              lines(df.IMC$bmc6, df.IMC$height, col=colours[6]);
              points(input$weight, input$height, col=colours[2], 
                     pch=6);
              legend('topleft', msgLegend, 
                     lty=c(1) , col=colours, 
                     bty='n', cex=.75)
              
            }
          )
          
        } 
      }
      
    )
    
    
    # Calculate and show the Optimal weight from this BMC level: (18.5+25)/2=21.75.
    output$textOutputRCM <- renderText(
      {
        input$goButton;
        if(input$goButton==0) msg<-""
        else{
          isolate( 
            {
              mw<-(21.75 * ((input$height/100)^2));
              mw<-round(mw, digits = 2);
              msg<- "Your recommended weight is: ";
              msg<- paste0(msg, mw);
              msg<- paste0(msg," Kg" );
              msg
            }
          )
        }
      } 
    );
  }
)
