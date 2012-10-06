From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v2 01/10] compiler-gcc4.h: Reorder macros based upon gcc
 ver
Date: Sat, 06 Oct 2012 12:54:07 -0500
Message-ID: <5070703F.8050004@att.net>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com> <1349466169-20637-1-git-send-email-daniel.santos@pobox.com> <20121006174220.GB6110@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm17-vm0.bullet.mail.ac4.yahoo.com ([98.139.53.208]:30368 "HELO
	nm17-vm0.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750841Ab2JFRyK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Oct 2012 13:54:10 -0400
In-Reply-To: <20121006174220.GB6110@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>

On 10/06/2012 12:42 PM, Borislav Petkov wrote:
>> @@ -56,10 +65,3 @@
>>  #define __visible __attribute__((externally_visible))
>>  #endif
>>  
>> -#if __GNUC_MINOR__ > 0
>> -#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>> -#endif
>> -#if __GNUC_MINOR__ >= 3 && !defined(__CHECKER__)
>
> This last hunk doesn't apply since mainline has a "4" above instead of
> "3". And it has had a "4" since it got added by 4a3127693001c so unless
> I'm missing something, how did the 3 appear in your patches?
These are based against -mm, where another commit is already in that
changes it.  I was told that since that commit was already in -mm, to
not include it in the patch set:

6c620cf1536a0ce6a83ecaaaf05298dcc0f7d440 (committed 2012-09-27)

This was probably (at least partially) the result of the fiasco I had
with my email.

