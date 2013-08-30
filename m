From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] adding into middle of RCU list
Date: Thu, 29 Aug 2013 17:57:33 -0700
Message-ID: <20130830005733.GA20664@linux.vnet.ibm.com>
References: <20130822213318.49a57fa2@nehalam.linuxnetplumber.net>
 <20130823164637.GB3871@linux.vnet.ibm.com>
 <20130823171653.GA16558@Krystal>
 <20130823210822.GD3871@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60380 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab3H3A5z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 Aug 2013 20:57:55 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 29 Aug 2013 18:57:54 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6DD201FF001C
	for <linux-sparse@vger.kernel.org>; Thu, 29 Aug 2013 18:57:51 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r7U0vpQm144950
	for <linux-sparse@vger.kernel.org>; Thu, 29 Aug 2013 18:57:51 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r7U10hoX005752
	for <linux-sparse@vger.kernel.org>; Thu, 29 Aug 2013 19:00:44 -0600
Content-Disposition: inline
In-Reply-To: <20130823210822.GD3871@linux.vnet.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, lttng-dev@lists.lttng.org, josh@joshtriplett.org, sparse@chrisli.org, linux-sparse@vger.kernel.org

On Fri, Aug 23, 2013 at 02:08:22PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 23, 2013 at 01:16:53PM -0400, Mathieu Desnoyers wrote:
> > * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > > On Thu, Aug 22, 2013 at 09:33:18PM -0700, Stephen Hemminger wrote:

[ . . . ]

> > > > +
> > > > +/**
> > > > + * Splice an RCU-protected list into an existing list.
> > > > + *
> > > > + * Note that this function blocks in synchronize_rcu()
> > > > + *
> > > > + * Important note: this function is not called concurrently
> > > > + *       with other updates to the list.
> > > > + */
> > > > +static inline void caa_list_splice_init_rcu(struct cds_list_head *list,
> > > > +					    struct cds_list_head *head)
> > > > +{
> > > > +	struct cds_list_head *first = list->next;
> > > > +	struct cds_list_head *last = list->prev;
> > > > +	struct cds_list_head *at = head->next;
> > > > +
> > > > +	if (cds_list_empty(list))
> > > > +		return;
> > > > +
> > > > +	/* "first" and "last" tracking list, so initialize it. */
> > > > +	CDS_INIT_LIST_HEAD(list);
> > > 
> > > This change is happening in the presence of readers on the list, right?
> > > For this to work reliably in the presence of mischievous compilers,
> > > wouldn't CDS_INIT_LIST_HEAD() need to use CMM_ACCESS_ONCE() for its
> > > pointer accesses?
> > 
> > Actually, we have rcu_assign_pointer()/rcu_set_pointer() exactly for
> > this. They even skip the memory barrier if they store a NULL pointer.
> > 
> > > Hmmm...  The kernel version seems to have the same issue...
> > 
> > The compiler memory model of the Linux kernel AFAIK does not require an
> > ACCESS_ONCE() for stores to word-aligned, word-sized integers/pointers,
> > even if those are expected to be read concurrently. For reference, see:
> > 
> > #define __rcu_assign_pointer(p, v, space) \
> >         do { \
> >                 smp_wmb(); \
> >                 (p) = (typeof(*v) __force space *)(v); \
> >         } while (0)
> 
> Or I need to fix this one as well.  ;-)

In that vein...  Is there anything like typeof() that also preserves
sparse's notion of address space?  Wrapping an ACCESS_ONCE() around
"p" in the assignment above results in sparse errors.

							Thanx, Paul

							Thanx, Paul

