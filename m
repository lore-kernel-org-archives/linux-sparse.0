From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH] fix sparse happy borkage when including gfp.h
Date: Fri, 15 Apr 2011 07:27:54 -0700
Message-ID: <1302877674.16562.3089.camel@nimitz>
References: <20110415121424.F7A6.A69D9226@jp.fujitsu.com>
	 <1302844066.16562.1953.camel@nimitz>
	 <20110415143259.F7BD.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20110415143259.F7BD.A69D9226@jp.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Fri, 2011-04-15 at 14:33 +0900, KOSAKI Motohiro wrote:
> Hello,
> > On Fri, 2011-04-15 at 12:14 +0900, KOSAKI Motohiro wrote:
> > > >  #ifdef CONFIG_DEBUG_VM
> > > > -             BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > > > +     BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > > >  #endif
> > > > -     }
> > > >       return z;
> > > 
> > > Why don't you use VM_BUG_ON?
> > 
> > I was just trying to make a minimal patch that did a single thing.
> > 
> > Feel free to submit another one that does that.  I'm sure there are a
> > couple more places that could use similar love.
> 
> I posted another approach patches a second ago. Could you please see it?

Those both look sane to me.  Those weren't biting me in particular, and
they don't fix the issue I was seeing.  But, they do seem necessary to
reduce some of the noise.

CC'ing the sparse mailing list.  We're seeing a couple of cases where
some gcc-isms are either stopping sparse from finding real bugs:

	http://marc.info/?l=linux-mm&m=130282454732689&w=2

or creating a lot of noise on some builds:

	http://marc.info/?l=linux-mm&m=130284428614058&w=2
	http://marc.info/?l=linux-mm&m=130284431014077&w=2

-- Dave

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
