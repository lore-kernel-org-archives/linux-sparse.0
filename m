From: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 0/3] Examples for the new sparse context tracking functionality
Date: Mon, 21 Apr 2008 07:55:25 -0700
Message-ID: <20080421145525.GB9153@linux.vnet.ibm.com>
References: <20080410134810.629048000@sipsolutions.net> <20080419233338.GG20138@linux.vnet.ibm.com> <1208766355.26186.37.camel@johannes.berg>
Reply-To: paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1208766355.26186.37.camel-YfaajirXv214zXjbi5bjpg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Triplett <josh-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Apr 21, 2008 at 10:25:55AM +0200, Johannes Berg wrote:
> 
> > At some point in the future, we might want to distinguish between
> > the different flavors of RCU -- except that there is already common
> > code that doesn't care which flavor of RCU is in use, as long as
> > some sort of RCU is present.  So make that "some point in the distant
> > future"...
> 
> No big deal, just declare
> 
> my_specific_rcu_get() __acquires(RCU) __acquires(specificRCU);
> 
> and then annotate whatever needs the specific RCU type with
> __requires(specificRCU)

Cute!!!  I didn't realize you could mark a single interface with
multiple __acquires() markings.

So if there is at least one match, sparse is happy?

							Thanx, Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
