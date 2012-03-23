From: Christopher Li <sparse@chrisli.org>
Subject: help needed: document __nocast vs __bitwise (Was: [PATCH 00/16] mm:
 prepare for converting vm->vm_flags to 64-bit)
Date: Fri, 23 Mar 2012 11:17:10 -0700
Message-ID: <CANeU7Q=GAcLy121eKQhuSkgKo06wRkpmLQTWc5WQgPN3RcjMjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54852 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab2CWSRM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 14:17:12 -0400
Received: by wejx9 with SMTP id x9so2855830wej.19
        for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2012 11:17:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Linus has a very nice write up about __nocast vs __bitwise.

Can any one help to integrate the write up to a patch
against man page sparse.1?

I would much rather hitting the apply button than hacking
documents. But if nobody wants to do it, it would have to
be me then.

Yes, I am a lazy baster :-)

Thanks

Chris

---------- Forwarded message ----------
=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, Mar 22, 2012 at 3:08 PM
Subject: Re: [PATCH 00/16] mm: prepare for converting vm->vm_flags to 6=
4-bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Konstantin Khlebnikov
<khlebnikov@openvz.org>, Minchan Kim <minchan@kernel.org>,
"linux-mm@kvack.org" <linux-mm@kvack.org>,
"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hugh
Dickins <hughd@google.com>, KOSAKI Motohiro
<kosaki.motohiro@jp.fujitsu.com>, Ben Herrenschmidt
<benh@kernel.crashing.org>, "linux@arm.linux.org.uk"
<linux@arm.linux.org.uk>


On Thu, Mar 22, 2012 at 2:41 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>>
>> Use __bitwise for that - check how gfp_t is handled.
>
> So what does __nocast do?

__nocast warns about explicit or implicit casting to different types.

HOWEVER, it doesn't consider two 32-bit integers to be different
types, so a __nocast 'int' type may be returned as a regular 'int'
type and then the __nocast is lost.

So "__nocast" on integer types is usually not that powerful. It just
gets lost too easily. It's more useful for things like pointers. It
also doesn't warn about the mixing: you can add integers to __nocast
integer types, and it's not really considered anything wrong.

__bitwise ends up being a "stronger integer separation". That one
doesn't allow you to mix with non-bitwise integers, so now it's much
harder to lose the type by mistake.

So basic rules is:

=A0- "__nocast" on its own tends to be more useful for *big* integers
that still need to act like integers, but you want to make it much
less likely that they get truncated by mistake. So a 64-bit integer
that you don't want to mistakenly/silently be returned as "int", for
example. But they mix well with random integer types, so you can add
to them etc without using anything special. However, that mixing also
means that the __nocast really gets lost fairly easily.

=A0- "__bitwise" is for *unique types* that cannot be mixed with other
types, and that you'd never want to just use as a random integer (the
integer 0 is special, though, and gets silently accepted iirc - it's
kind of like "NULL" for pointers). So "gfp_t" or the "safe endianness"
types would be __bitwise: you can only operate on them by doing
specific operations that know about *that* particular type.

Generally, you want __bitwise if you are looking for type safety.
"__nocast" really is pretty weak.

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
Please read the FAQ at =A0http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
