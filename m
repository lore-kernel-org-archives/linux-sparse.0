From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 7/10] compiler{,-gcc4}.h: Introduce __flatten function
 attribute
Date: Wed, 03 Oct 2012 09:46:40 -0500
Message-ID: <506C4FD0.4040307@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-8-git-send-email-daniel.santos@pobox.com> <20120929002626.GD13907@jtriplet-mobl1> <50664308.6020601@att.net> <20120929005043.GD14293@jtriplet-mobl1> <alpine.DEB.2.00.1210022347500.12717@chino.kir.corp.google.com> <20121003065959.GA4963@leaf> <alpine.DEB.2.00.1210030052040.16922@chino.kir.corp.google.com> <506C1F8B.1070307@att.net> <1349272914.22822.169.camel@gandalf.local.home>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm12.bullet.mail.sp2.yahoo.com ([98.139.91.82]:45437 "HELO
	nm12.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754415Ab2JCOqm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Oct 2012 10:46:42 -0400
In-Reply-To: <1349272914.22822.169.camel@gandalf.local.home>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, David Rientjes <rientjes@google.com>, Josh Triplett <josh@joshtriplett.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On 10/03/2012 09:01 AM, Steven Rostedt wrote:
> On Wed, 2012-10-03 at 06:20 -0500, Daniel Santos wrote:
>
>>> Daniel, please introduce __flatten in the patch series that uses it, 
>>> thanks.
>> That isn't going to work. I split my patches out into three sets
>> because, otherwise, the list of maintainers that must be CCed exceeds
>> the allowable size of the LKML server and my messages get tagged as
>> spam, causing untold confusion as messages reach maintainers, but not
>> the LKML.  Please note from the summary of this patch set
>> (https://lkml.org/lkml/2012/9/28/1136)
> That's not a valid reason to not included it with the other patch
> series.
>
>>> This patch set is a dependency of the generic red-black tree patch set, which
>>> I have now split up into three smaller sets.
>> And the patch set this depends upon was submitted 9/28 as well
>> (https://lkml.org/lkml/2012/9/28/1183) and the summary starts with this
>> text:
>>> This patch set depends upon the following:
>>> * Cleanup & new features for compiler*.h and bug.h
>>> * kernel-doc bug fixes (for generating docs)
>> If I move this patch to the other patch set,
>> scripts/get_maintainers.pl will give me a list longer than the LKML
>> administrator will allow for recipients (1024 bytes max)
> You don't need to use get_maintainers. It's more of a help tool to find
> maintainers and not something that is mandatory. Not everyone that has
> ever touched one of these files needs to be Cc'd.
>
> Please move the patch to the patch series where it is used. Otherwise it
> confuses reviewers as it did here.
Ok then, but this would also apply to the addition of these macros as well:
BUILD_BUG_ON_NON_CONST
BUILD_BUG42
BUILD_BUG_ON_NON_CONST42

Should these then also be moved?
Should I only CC those who have responded to these patches and whomever
is in the MAINTAINERS file then?

Thanks
Daniel

