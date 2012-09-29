From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [Bulk] Re: [PATCH 4/10] compiler-gcc{3,4}.h: Use GCC_VERSION
 macro
Date: Fri, 28 Sep 2012 19:31:53 -0500
Message-ID: <50664179.5090608@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-5-git-send-email-daniel.santos@pobox.com> <20120929002029.GA13907@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm10-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.198]:37605 "HELO
	nm10-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758443Ab2I2Aby (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 20:31:54 -0400
In-Reply-To: <20120929002029.GA13907@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 09/28/2012 07:20 PM, Josh Triplett wrote:
> On Fri, Sep 28, 2012 at 06:20:05PM -0500, Daniel Santos wrote:
>> --- a/include/linux/compiler-gcc4.h
>> +++ b/include/linux/compiler-gcc4.h
>> @@ -13,11 +13,11 @@
>>  #define __must_check 		__attribute__((warn_unused_result))
>>  #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
>>  
>> -#if __GNUC_MINOR__ > 0
>> +#if GCC_VERSION >= 40102
>>  # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>>  #endif
> You've changed the semantics of this one; if literally translated, this
> should have become #if GCC_VERSION >= 40100.  If you intended to change
> that, could you please document why?  And in any case, could you make
> that semantic change in a separate commit from the switch to
> GCC_VERSION?
hmm, it looks like somebody commented out the #error that would normally
prevent that test from ever occurring on 4.1.0 or 4.1.1.
When I had written this patch, it wasn't commented out and I had assumed
that it was obvious from the context.
>  /* GCC 4.1.[01] miscompiles __weak */
>  #ifdef __KERNEL__
> -# if __GNUC_MINOR__ == 1 && __GNUC_PATCHLEVEL__ <= 1
> +# if GCC_VERSION >= 40100 &&  GCC_VERSION <= 40101
>  //#  error Your version of gcc miscompiles the __weak directive
>  # endif
>  #endif
> @@ -13,11 +13,11 @@
>  #define __must_check 		__attribute__((warn_unused_result))
>  #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
>  
> -#if __GNUC_MINOR__ > 0
> +#if GCC_VERSION >= 40102
>  # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>  #endif
I would say that commenting this out is bad if __weak is miscompiled. 
If we don't want to break the build, should we at least be defining
__weak to something else?

Daniel
