From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [Bulk] Re: [PATCH 5/10] compiler{,-gcc4}.h: Remove duplicate
 macros
Date: Fri, 28 Sep 2012 19:34:36 -0500
Message-ID: <5066421C.20904@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-6-git-send-email-daniel.santos@pobox.com> <20120929002329.GB13907@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm14.bullet.mail.sp2.yahoo.com ([98.139.91.84]:25752 "HELO
	nm14.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759241Ab2I2Aei (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 20:34:38 -0400
In-Reply-To: <20120929002329.GB13907@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 09/28/2012 07:23 PM, Josh Triplett wrote:
> On Fri, Sep 28, 2012 at 06:20:06PM -0500, Daniel Santos wrote:
>> __linktime_error() does the same thing as __compiletime_error() and is
>> only used in bug.h.  Since the macro defines a function attribute that
>> will cause a failure at compile-time (not link-time), it makes more
>> sense to keep __compiletime_error(), which is also neatly mated with
>> __compiletime_warning().
>>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Why not change bug.h in the same commit?  Or alternatively, why not
> change it first?
I'm still new to this project's development process and wasn't sure if
those two changes would be considered lumping multiple changes together
or not.  So that type of lumping is acceptable then?  I certainly
wouldn't mind squashing them.
> Getting rid of __linktime_error *before* changing its
> use in bug.h to __compiletime_error seems wrong.
Good point!

