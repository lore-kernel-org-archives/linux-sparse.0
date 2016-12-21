From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: cgcc and -Dx86_64
Date: Wed, 21 Dec 2016 12:45:32 -0500
Message-ID: <349d321e-43f7-f7c0-b985-7303fdb78ef9@redhat.com>
References: <13736b0d-b29a-0118-6846-f08bb3bb76f4@redhat.com>
 <CA+55aFxawUQnNhuVMqLmXMJj1Kek6NruD2K27AN_cGqNLHi+hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756741AbcLURpe (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Dec 2016 12:45:34 -0500
In-Reply-To: <CA+55aFxawUQnNhuVMqLmXMJj1Kek6NruD2K27AN_cGqNLHi+hg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 12/21/2016 12:13 PM, Linus Torvalds wrote:
> On Wed, Dec 21, 2016 at 8:07 AM, Joe Lawrence <joe.lawrence@redhat.com> wrote:
>>
>> I was trying to run sparse against the upstream kpatch project and ran
>> into problems with an include file that defined an "x86_64" variable:
> 
> Yeah,. that's bogus. It should be removed. It goes back to the
> original x86-64 specific cgcc patch from 2007 (commit 0fcbcbf:
> "Implement x86-64 support in cgcc").
> 
> It may be that old versions of gcc did the same, who knows. They
> definitely don't any more, I checked:
> 
>   $ gcc -dM -E - < /dev/null | grep -v 'define __'
> 
>   #define _STDC_PREDEF_H 1
>   #define unix 1
>   #define linux 1
>   #define _LP64 1
> 
> and so gcc itself definitely doesn't do the x86_64 thing (it does
> pre-define versions with double underscores before and after):
> 
>   $ gcc -dM -E - < /dev/null | grep x86
>   #define __x86_64 1
>   #define __x86_64__ 1
> 
>> I can avoid this by renaming the structure member to something like
>> "foo_x86_64".  I believe the problem stems from cgcc passing "-Dx86_64"
>> to gcc... sparse later gets confused as there is now a preprocessor
>> variable defined with the same name.
> 
> You shouldn't need that.
> 
>> We could s/x86_64/something_else/g across the whole project to avoid
>> this glitch, but was wondering if there was a better way.
> 
> The fix it so just remove x86_64 from cgcc. It already does define the
> underscored versions.
> 
> Same for the other architectures, for that matter. Obvios trivial (and
> totally untested) patch attached.
> 

Thanks, Linus!

The patch worked well for me, so consider this tested (on x86_64 at least).

-- Joe

