From: Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 3/3] mac80211: annotate with __requires_rcu
Date: Sat, 12 Apr 2008 10:50:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804121050160.28120@vixen.sonytel.be>
References: <20080410134810.629048000@sipsolutions.net>
 <20080410134829.412424000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-1964633417-1207990251=:28120"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080410134829.412424000-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Triplett <josh-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1964633417-1207990251=:28120
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 10 Apr 2008, Johannes Berg wrote:
> --- everything.orig/net/mac80211/key.h	2008-04-10 15:36:20.000000000 +0200
> +++ everything/net/mac80211/key.h	2008-04-10 15:36:45.000000000 +0200
> @@ -146,7 +146,7 @@ struct ieee80211_key *ieee80211_key_allo
>   */
>  void ieee80211_key_link(struct ieee80211_key *key,
>  			struct ieee80211_sub_if_data *sdata,
> -			struct sta_info *sta);
> +			struct sta_info *sta) __requires(RCU);
                                              ^^^^^^^^^^^^^^^
					      __requires_rcu? (for consistency)

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584349381-1964633417-1207990251=:28120--
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
