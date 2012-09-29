From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH 7/10] compiler{,-gcc4}.h: Introduce __flatten function
 attribute
Date: Fri, 28 Sep 2012 19:38:32 -0500
Message-ID: <50664308.6020601@att.net>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com> <1348874411-28288-8-git-send-email-daniel.santos@pobox.com> <20120929002626.GD13907@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm36-vm7.bullet.mail.bf1.yahoo.com ([72.30.238.143]:43688 "HELO
	nm36-vm7.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758306Ab2I2Ant (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 20:43:49 -0400
In-Reply-To: <20120929002626.GD13907@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

On 09/28/2012 07:26 PM, Josh Triplett wrote:
> On Fri, Sep 28, 2012 at 06:20:08PM -0500, Daniel Santos wrote:
>> --- a/include/linux/compiler-gcc4.h
>> +++ b/include/linux/compiler-gcc4.h
>> @@ -15,7 +15,12 @@
>>  
>>  #if GCC_VERSION >= 40102
>>  # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>> -#endif
>> +
>> +/* flatten introduced in 4.1, but broken in 4.6.0 (gcc bug #48731)*/
>> +# if GCC_VERSION != 40600
>> +#  define __flatten __attribute__((flatten))
>> +# endif
>> +#endif /* GCC_VERSION >= 40102 */
> Same comment as before: why 40102 rather than 40100?
Again, I'm presuming building with 4.1.0 or 4.1.1 will always have the
build broken earlier.  I don't have any objections to changing this, but
it would seem that the issue with the __weak attribute needs to be resolved.

Daniel
