From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Wed, 24 Dec 2008 15:10:31 -0800
Message-ID: <70318cbf0812241510o2318f701w938840b9123fb9e4@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
	 <4950A8A2.5090702@knosof.co.uk>
	 <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>
	 <495181C0.7070803@knosof.co.uk>
	 <f19298770812231839n1aaaf84fla96dda04b11e0944@mail.gmail.com>
	 <4952B0AD.7040007@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:51744 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYLXXKb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 18:10:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3035597rvb.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 15:10:31 -0800 (PST)
In-Reply-To: <4952B0AD.7040007@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Dec 24, 2008 at 1:59 PM, David Given <dg@cowlark.com> wrote:
> The thing is, sizeof(void) is *not* 1. sizeof(void) is *illegal*. It
> just happens that gcc, as a platform-specific extension, treats
> sizeof(void) as 1 by default.

Exactly. I am unhappy about that patch as well.
Sparse internally use symbol->bit_size == 0 to determine uncompleted type.
Thanks this change. Now is_byte_type() will return true for void type as well.

> As a linter, sparse really ought not to be encouraging non-portable
> behaviour. Admittedly, there's so much stuff in the kernel source that's
> gcc-specific that it's probably not going to be possible to make it
> build on anything else, but it should still warn people about it unless
> specifically told otherwise --- it's bad practice, and may be indicative
> of further problems elsewhere, and as such is worth a diagnostic.

I don't see the kernel directly use sizeof(void). Most of the place is
using (void*) pointer + offset. It is not portable. But it is probably not
worthy while to fix. Convert the void* to char*, add offset, convert it back
to void* is pretty annoying as well. If we really want to make it clean, maybe
we can use a macro or inline functions. Again, probably not worth the effort.

But legitimize sizeof(void) == 1 is a different story. That I feel is just
plain wrong.

Even gcc is self contradicting regarding the size of void.
Compiling "void i;" will give you:
/tmp/void.c:1: error: storage size of 'i' isn't known

I saw Josh just merge the sizeof(void) patch. Oh well.

Chris
