From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Thu, 25 Dec 2008 20:12:56 +0300
Message-ID: <f19298770812250912p5e3c1ecan419339a0dc847cce@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
	 <4950A8A2.5090702@knosof.co.uk>
	 <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>
	 <495181C0.7070803@knosof.co.uk>
	 <f19298770812231839n1aaaf84fla96dda04b11e0944@mail.gmail.com>
	 <4952B0AD.7040007@cowlark.com>
	 <70318cbf0812241510o2318f701w938840b9123fb9e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:53791 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYLYRM7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2008 12:12:59 -0500
Received: by bwz14 with SMTP id 14so12956551bwz.13
        for <linux-sparse@vger.kernel.org>; Thu, 25 Dec 2008 09:12:56 -0800 (PST)
In-Reply-To: <70318cbf0812241510o2318f701w938840b9123fb9e4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Thu, Dec 25, 2008 at 02:10, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Dec 24, 2008 at 1:59 PM, David Given <dg@cowlark.com> wrote:
>> The thing is, sizeof(void) is *not* 1. sizeof(void) is *illegal*. It
>> just happens that gcc, as a platform-specific extension, treats
>> sizeof(void) as 1 by default.
>
> Exactly. I am unhappy about that patch as well.
> Sparse internally use symbol->bit_size == 0 to determine uncompleted type.
> Thanks this change. Now is_byte_type() will return true for void type as well.

I can only agree here. I made my patch that way only because of my poor
understanding of the sparse internals (which I stated in my first email).

>> As a linter, sparse really ought not to be encouraging non-portable
>> behaviour. Admittedly, there's so much stuff in the kernel source that's
>> gcc-specific that it's probably not going to be possible to make it
>> build on anything else, but it should still warn people about it unless
>> specifically told otherwise --- it's bad practice, and may be indicative
>> of further problems elsewhere, and as such is worth a diagnostic.
>
> I don't see the kernel directly use sizeof(void). Most of the place is
> using (void*) pointer + offset. It is not portable. But it is probably not
> worthy while to fix. Convert the void* to char*, add offset, convert it back
> to void* is pretty annoying as well. If we really want to make it clean, maybe
> we can use a macro or inline functions. Again, probably not worth the effort.
>
> But legitimize sizeof(void) == 1 is a different story. That I feel is just
> plain wrong.

Of course explicit sizeof(void) itself is just plain wrong, but also
it's something
that nobody would ever use. So, if you warn here, I of course have no
objections.
