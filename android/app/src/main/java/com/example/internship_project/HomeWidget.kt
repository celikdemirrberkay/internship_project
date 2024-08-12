package com.example.internship_project

import android.annotation.SuppressLint
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Implementation of App Widget functionality.
 */
class HomeWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
           val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.home_widget)
            // Taking data from the widgets
            val fajr = widgetData.getString("Fajr","-")
            val sunrise = widgetData.getString("Sunrise","-")
            val dhuhr = widgetData.getString("Dhuhr","-")
            val asr = widgetData.getString("Asr","-")
            val maghrib = widgetData.getString("Maghrib","-")
            val isha = widgetData.getString("Isha","-")
            val location = widgetData.getString("Location","-")
            val remainingTimeHours = widgetData.getString("RemainingTimeHours","-")
            val remainingTimeMinutes = widgetData.getString("RemainingTimeMinutes","-")
            val remainingTimeSeconds = widgetData.getString("RemainingTimeSeconds","-")

            // Setting data to the widgets
            views.setTextViewText(R.id.fajr_time, fajr)
            views.setTextViewText(R.id.sunrise_time, sunrise)
            views.setTextViewText(R.id.dhuhr_time, dhuhr)
            views.setTextViewText(R.id.asr_time, asr)
            views.setTextViewText(R.id.maghrib_time, maghrib)
            views.setTextViewText(R.id.isha_time, isha)
            views.setTextViewText(R.id.location, location)
            views.setTextViewText(R.id.remaining_time_hours, remainingTimeHours)
            views.setTextViewText(R.id.remaining_time_minutes, remainingTimeMinutes)
            views.setTextViewText(R.id.remaining_time_seconds, remainingTimeSeconds)

            appWidgetManager.updateAppWidget(appWidgetId,views)


        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

