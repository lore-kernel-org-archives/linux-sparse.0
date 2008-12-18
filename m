From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Thu, 18 Dec 2008 03:33:45 +0300
Message-ID: <f19298770812171633w43707eb0h8c0a0be262549ddf@mail.gmail.com>
References: <20081217190534.24084.94887.stgit@zaytsev.su>
	 <49498C67.4000700@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:25805 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbYLRAds (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Dec 2008 19:33:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so90992wah.21
        for <linux-sparse@vger.kernel.org>; Wed, 17 Dec 2008 16:33:46 -0800 (PST)
In-Reply-To: <49498C67.4000700@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Thu, Dec 18, 2008 at 02:33, David Given <dg@cowlark.com> wrote:
> Alexey Zaytsev wrote:
> [...]
>> This problem may be addressed by changing bits_to_bytes to
>> static inline int bits_to_bytes(int bits)
>> {
>>        return bits >= 0 ? bits / bits_in_char : -1;
>> }
>
> That's fine by me (although I've been using my version for ages now with
> no apparent problems --- just out of interest, Clue is now using Sparse
> to compile C into Lua, Javascript, Perl 5, Common Lisp, C and Java
> moderately successfully).
Just try to run sparse over the Linux kernel. It fireas at least at
void * pointer manipulation and (some?) offsetof()'s. Maybe
somewhere else.

>
>> But it seems there is also a bug in sparse, as in
>> ctype_declaration[] the bit_size of void_ctype is
>> set to NULL, while gcc assumes sizeof(void) being 1.
>> Currently sparse would generate wrong code for:
> [...]
>> unsigned long test1(void *p)
>> {
>>         return sizeof(*p);
>> }
>
> TBH, I don't think that's legal --- I know of several compilers that
> will refuse to compile it, and gcc -pedantic produces a warning, which
> means it probably falls into the 'undefined behaviour' bucket of the
> standard. I can't find anything that specifically talks about sizeof
> void, but 6.3.2.2.1 prohibits doing *anything* with the result of an
> expression of type void, which sort of applies here.
>
> Of course, I'm thinking about this from the sparse-as-a-compiler point
> of view, where you're probably more interested in replicating gcc's
> behaviour.

This seems to be legal, and quite popular in the Linux kernel. GNU C defines
sizeof(void) being 1.And as it has the -Wpointer-arith flag, this kind of stuff
may be caught without sparse if deemed undesirable.

P.S:
Please, sign off this patch and the one adding type information to
struct instruction.
