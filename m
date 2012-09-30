From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 6/10] bug.h: Replace __linktime_error with __compiletime_error
Date: Sun, 30 Sep 2012 16:13:22 -0500
Message-ID: <5068B5F2.7030800@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-7-git-send-email-daniel.santos@pobox.com> <20120929002353.GC13907@jtriplet-mobl1> <1348880675.22822.102.camel@gandalf.local.home> <20120930132233.GB15400@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm35-vm7.bullet.mail.ne1.yahoo.com ([98.138.229.103]:47575 "HELO
	nm35-vm7.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751487Ab2I3VNV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Sep 2012 17:13:21 -0400
In-Reply-To: <20120930132233.GB15400@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>, Josh Triplett <josh@joshtriplett.org>, Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>



On 09/30/2012 08:22 AM, Borislav Petkov wrote:
> On Fri, Sep 28, 2012 at 09:04:35PM -0400, Steven Rostedt wrote:
>> On Fri, 2012-09-28 at 17:23 -0700, Josh Triplett wrote:
>>> On Fri, Sep 28, 2012 at 06:20:07PM -0500, Daniel Santos wrote:
>>>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>>>> ---
>>>>  include/linux/bug.h |    2 +-
>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/include/linux/bug.h b/include/linux/bug.h
>>>> index aaac4bb..298a916 100644
>>>> --- a/include/linux/bug.h
>>>> +++ b/include/linux/bug.h
>>>> @@ -73,7 +73,7 @@ extern int __build_bug_on_failed;
>>>>  #define BUILD_BUG()						\
>>>>  	do {							\
>>>>  		extern void __build_bug_failed(void)		\
>>>> -			__linktime_error("BUILD_BUG failed");	\
>>>> +			__compiletime_error("BUILD_BUG failed");\
>>>>  		__build_bug_failed();				\
>>>>  	} while (0)
>>> This change should either occur as part of patch 5 or before patch 5,
>>> not after.
>> I noticed the same thing and was about to comment on it.
>>
>> Please do not break bisectablity. All your patches should compile and
>> run at every step.
> And while we're at it, every patch upstream should have a commit message
> explaining why this is done. No matter how trivial it is, because after
> a sufficient amount of time passes, everyone tends to forget why this
> has been done.
>
> Thanks.
>
Ah, well thank you all for the guidance!

Daniel
