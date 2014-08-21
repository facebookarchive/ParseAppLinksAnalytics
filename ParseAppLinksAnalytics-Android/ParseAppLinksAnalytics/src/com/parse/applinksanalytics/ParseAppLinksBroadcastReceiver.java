/**
 * Copyright (c) 2014, Parse, LLC. All rights reserved.
 *
 * You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
 * copy, modify, and distribute this software in source code or binary form for use
 * in connection with the web services and APIs provided by Parse.

 * As with any software that integrates with the Parse platform, your use of
 * this software is subject to the Parse Terms of Service
 * [https://www.parse.com/about/terms]. This copyright notice shall be
 * included in all copies or substantial portions of the software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */
package com.parse.applinksanalytics;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;

import com.parse.ParseAnalytics;

/**
 * This class implements a BroadcastReceiver that listens for notifications from
 * Bolts App Link events and creates a Parse Analytics custom event for
 * recognized notifications. The event name translations from Bolts to Parse
 * are:
 * 
 * al_nav_in: AppLinksInbound - This is sent when an App Links URL opens your
 * app.
 * 
 * al_nav_out: AppLinksOutbound - This is sent when your app opens an App Links
 * URL.
 */
/* package */class ParseAppLinksBroadcastReceiver extends BroadcastReceiver {

	private static final String EVENT_NOTIFICATION_NAME = "com.parse.bolts.measurement_event";
	private static final String EVENT_NAME_KEY = "event_name";
	private static final String EVENT_ARGS_KEY = "event_args";

	private static final Map<String, String> EVENT_NAME_MAP;
	static {
		Map<String, String> map = new HashMap<String, String>();
		map.put("al_nav_in", "AppLinksInbound");
		map.put("al_nav_out", "AppLinksOutbound");
		EVENT_NAME_MAP = Collections.unmodifiableMap(map);
	}

	private static ParseAppLinksBroadcastReceiver instance;

	/**
	 * Initializes the local broadcast receiver if necessary.
	 * 
	 * @param context
	 *            Used to register the receiver.
	 */
	public static void initialize(Context context) {
		if (instance == null) {
			instance = new ParseAppLinksBroadcastReceiver(context);
		}
	}

	private static Map<String, String> convertBundleToMap(Bundle bundle) {
		Map<String, String> map = new HashMap<String, String>();
		for (String key : bundle.keySet()) {
			map.put(key, bundle.getString(key));
		}
		return map;
	}

	private Context applicationContext;

	/**
	 * Constructor registers the receiver and saves the context.
	 */
	private ParseAppLinksBroadcastReceiver(Context context) {
		applicationContext = context.getApplicationContext();
		this.register();
	}

	@Override
	public void onReceive(Context context, Intent intent) {
		Bundle extras = intent.getExtras();
		String eventName = intent.getExtras().getString(EVENT_NAME_KEY);
		// Only log custom event if it's recognized and in the map
		if (EVENT_NAME_MAP.containsKey(eventName)) {
			String eventNameMapped = EVENT_NAME_MAP.get(eventName);
			Map<String, String> dimensions = convertBundleToMap(extras
					.getBundle(EVENT_ARGS_KEY));
			ParseAnalytics.trackEvent(eventNameMapped, dimensions);
		}
	}

	@Override
	protected void finalize() throws Throwable {
		try {
			unregister();
		} finally {
			super.finalize();
		}
	}

	private void register() {
		LocalBroadcastManager broadcastManager = LocalBroadcastManager
				.getInstance(applicationContext);
		broadcastManager.registerReceiver(this, new IntentFilter(
				EVENT_NOTIFICATION_NAME));
	}

	private void unregister() {
		LocalBroadcastManager broadcastManager = LocalBroadcastManager
				.getInstance(applicationContext);
		broadcastManager.unregisterReceiver(this);
	}
}
