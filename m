From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 6/10] bug.h: Replace __linktime_error with __compiletime_error
Date: Wed, 03 Oct 2012 19:26:46 -0500
Message-ID: <506CD7C6.2000500@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-7-git-send-email-daniel.santos@pobox.com> <alpine.DEB.2.00.1210022344180.12717@chino.kir.corp.google.com> <506C2636.6020304@att.net> <alpine.DEB.2.00.1210031122020.2412@chino.kir.corp.google.com>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1210031122020.2412@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

On 10/03/2012 01:26 PM, David Rientjes wrote:
> On Wed, 3 Oct 2012, Daniel Santos wrote:
>
>> Thanks.  I've actually just reversed the patch order per Josh's
>> suggestion and added patch comments to it.  I can squash them if you
>> guys prefer.
>>
> No need to be so fine-grained in your patches, if you're trying to replace 
> __linktime_error with __compiletime_error, which happens to be the title 
> of the patch (and should remain the title), then just remove it's single 
> occurrence and its definition at the same time with a clear changelog that 
> __compiletime_error is sufficient.  No need to have two small patches with 
> the same motivation.
Sounds good to me
>
>> Unfortunately, I'm a bit confused as to how I should re-submit these,
>> still being new to this project.  Patch 1 is already in -mm. Patches 2-3
>> have not changed. I've made a correction to patch #4 and reversed the
>> order of 5 & 6. And what was 8-10 is now 8-15, as I've completely
>> re-done BUILD_BUG_ON.  I was planning on just submitting the whole set
>> again, is this the correct protocol?  If so, should I reply to the
>> original [PATCH 0/10] thread or create a new one?
>>
> You already have a patch in -mm, so you have to base your series on that 
> tree.  Get the latest -mm tree from http://www.ozlabs.org/~akpm/mmotm/ and 
> base the revised series on that tree, then send it off to 
> Andrew Morton <akpm@linux-foundation.org> and cc the list and your 
> reviewers.  People often find it helpful to make it clear that this is v2 
> of the patchset and that it's based on -mm as a helpful pointer.
I have it checked out from git://git.cmpxchg.org/linux-mmotm.git, the
problem is that I cannot correctly test against that right now because I
get an oops (without my patches) when setting up LVM (same on -next, bug
report here https://bugzilla.kernel.org/show_bug.cgi?id=48241).  What
I'm thinking about doing is to rebase them against v3.6 again and test
them there, but it will require a few minor changes (due to walken's
patches not being present).  Still, it's better than no re-testing.
Daniel
