From: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 0/3] Examples for the new sparse context tracking functionality
Date: Sat, 19 Apr 2008 16:33:38 -0700
Message-ID: <20080419233338.GG20138@linux.vnet.ibm.com>
References: <20080410134810.629048000@sipsolutions.net>
Reply-To: paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080410134810.629048000-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Triplett <josh-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Apr 10, 2008 at 03:48:10PM +0200, Johannes Berg wrote:
> Here are some patches that show how the new sparse functionality  
> could be used in the kernel if merged.
> 
> As mentioned before, I have actually found three bugs in mac80211
> using these patches. If you apply them and the sparse patches I have
> also just posted, you can find them too :)

I like this approach in general, deferring to Josh on specifics.

At some point in the future, we might want to distinguish between
the different flavors of RCU -- except that there is already common
code that doesn't care which flavor of RCU is in use, as long as
some sort of RCU is present.  So make that "some point in the distant
future"...

						Thanx, Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
