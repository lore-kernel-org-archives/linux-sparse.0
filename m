From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 7/10] compiler{,-gcc4}.h: Introduce __flatten function
 attribute
Date: Wed, 03 Oct 2012 11:14:01 -0400
Message-ID: <1349277241.22822.176.camel@gandalf.local.home>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
	 <1348874411-28288-8-git-send-email-daniel.santos@pobox.com>
	 <20120929002626.GD13907@jtriplet-mobl1> <50664308.6020601@att.net>
	 <20120929005043.GD14293@jtriplet-mobl1>
	 <alpine.DEB.2.00.1210022347500.12717@chino.kir.corp.google.com>
	 <20121003065959.GA4963@leaf>
	 <alpine.DEB.2.00.1210030052040.16922@chino.kir.corp.google.com>
	 <506C1F8B.1070307@att.net> <1349272914.22822.169.camel@gandalf.local.home>
	 <506C4FD0.4040307@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <506C4FD0.4040307@att.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: David Rientjes <rientjes@google.com>, Josh Triplett <josh@joshtriplett.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-sparse@vger.kernel.org

On Wed, 2012-10-03 at 09:46 -0500, Daniel Santos wrote:

> > Please move the patch to the patch series where it is used. Otherwise it
> > confuses reviewers as it did here.
> Ok then, but this would also apply to the addition of these macros as well:
> BUILD_BUG_ON_NON_CONST
> BUILD_BUG42
> BUILD_BUG_ON_NON_CONST42
> 
> Should these then also be moved?

If they are only used by the other patch set, sure.

> Should I only CC those who have responded to these patches and whomever
> is in the MAINTAINERS file then?

Yep. I personally never use the get_maintainers script. I first check
the MAINTAINERS file. If the subsystem I'm working on exists there, I
only email those that are listed there, including any mailing lists that
are mentioned (as well as LKML). If it's not listed, I then do a git log
and see who does the most sign offs to changes there, and to what kind
of changes. I usually ignore the trivial stuff.

-- Steve
