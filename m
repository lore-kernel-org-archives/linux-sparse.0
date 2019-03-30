From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Date: Sat, 30 Mar 2019 13:01:41 +0100
Message-ID: <20190330120139.ps4u7j6w4snnhkkb@ltop.local>
References: <20190325195303.GA20629@hari-Inspiron-1545>
 <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
 <20190330110747.GA3461@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190330110747.GA3461@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com, roopa@cumulusnetworks.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Mar 30, 2019 at 04:37:48PM +0530, Hariprasad Kelam wrote:
> On Sat, Mar 30, 2019 at 12:22:17AM +0100, Luc Van Oostenryck wrote:
> > On Tue, Mar 26, 2019 at 01:23:03AM +0530, Hariprasad Kelam wrote:
> > > This patch fixes below spare errors.
> > > 
> > > Sparse error:
> > > make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> > > ./include/trace/events/neigh.h:73:1: error: directive in argument list
> > > ./include/trace/events/neigh.h:78:1: error: directive in argument list
> > > ./include/trace/events/neigh.h:150:1: error: directive in argument list
> > > ./include/trace/events/neigh.h:155:1: error: directive in argument list
> > > 
> > > Changes below two lines to signle line to avoid sparse error
> > >  #if IS_ENABLED(CONFIG_IPV6)
> > >                if (n->tbl->family == AF_INET6) {
> > > to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> > > 
> > > and removes reassigning pin6 pointer when IPV6 is enabled
> > > 
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > > ---
> > >  include/trace/events/neigh.h | 19 +++++--------------
> > >  1 file changed, 5 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
> > > index 0bdb085..6e310ea 100644
> > > --- a/include/trace/events/neigh.h
> > > +++ b/include/trace/events/neigh.h
> > > @@ -70,15 +70,11 @@ TRACE_EVENT(neigh_update,
> > >  		else
> > >  			*p32 = 0;
> > >  
> > > -#if IS_ENABLED(CONFIG_IPV6)
> > > -		if (n->tbl->family == AF_INET6) {
> > > -			pin6 = (struct in6_addr *)__entry->primary_key6;
> > > +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> > >  			*pin6 = *(struct in6_addr *)n->primary_key;
> > 
> > Why removing the line wheer pin6 is assigned?
> > IMO, the patch should be:
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -		if (n->tbl->family == AF_INET6) {
> > +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> >  			pin6 = (struct in6_addr *)__entry->primary_key6;
> >   			*pin6 = *(struct in6_addr *)n->primary_key;
> > 
> > > @@ -147,15 +143,10 @@ DECLARE_EVENT_CLASS(neigh__update,
> > >  		else
> > >  			*p32 = 0;
> > >  
> > > -#if IS_ENABLED(CONFIG_IPV6)
> > > -		if (n->tbl->family == AF_INET6) {
> > > -			pin6 = (struct in6_addr *)__entry->primary_key6;
> >
> pin6  is already assigned.

OK, I see. IMO, it would be better to have 2 patches for this:
one for the redundant assignment to pin6 and anotther one for
the IS_ENABLED() change but feel free, if needed, to add my

  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


-- Luc
