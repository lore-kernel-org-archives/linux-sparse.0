From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v3 04/10] bug.h: directly include linux/compiler.h
Date: Sun, 28 Oct 2012 14:23:21 -0500
Message-ID: <508D8629.4040208@att.net>
References: <1351096132-12244-1-git-send-email-daniel.santos@pobox.com> <1351096441-12388-4-git-send-email-daniel.santos@pobox.com> <20121024195520.GD17945@liondog.tnic>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm17.access.bullet.mail.mud.yahoo.com ([66.94.237.218]:21286
	"EHLO nm17.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754713Ab2J1T2y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Oct 2012 15:28:54 -0400
In-Reply-To: <20121024195520.GD17945@liondog.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>

On 10/24/2012 02:55 PM, Borislav Petkov wrote:
> On Wed, Oct 24, 2012 at 11:33:55AM -0500, danielfsantos@att.net wrote:
>> Currently, we are only including asm/bug.h and then expecting that
>> linux/compiler.h will eventually be included to define __linktime_error
>> (used in BUILD_BUG_ON). This patch includes it directly for clarity and
>> to avoid the possibility of changes in <arch>/*/include/asm/bug.h being
>> changed or not including linux/compiler.h for some reason. (Later
>> patches will in this set use more macros defined in compiler*.h.)
>>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>> ---
>>  include/linux/bug.h |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/bug.h b/include/linux/bug.h
>> index aaac4bb..4bd74d8 100644
>> --- a/include/linux/bug.h
>> +++ b/include/linux/bug.h
>> @@ -2,6 +2,7 @@
>>  #define _LINUX_BUG_H
>>  
>>  #include <asm/bug.h>
>> +#include <linux/compiler.h>
>>  
>>  enum bug_trap_type {
>>  	BUG_TRAP_TYPE_NONE = 0,
>> -- 
>> 1.7.3.4
> Why is this a separate patch and why not add that single line in 6/10
> where you define BUILD_BUG_ON?
>
> Thanks.
Sorry about that.  I think this was originally in another patch with
something else that I moved to another patch set and it ended up by its
self.  I'll squash it and resubmit.

