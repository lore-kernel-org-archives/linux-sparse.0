From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Sun, 28 Aug 2011 09:54:03 -0700
Message-ID: <CA+55aFymNRxwWMVPwhWKGB7T2UXduGccjW1FgKYGCb8QH9QAhg@mail.gmail.com>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>
 <CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com> <alpine.DEB.2.00.1108281700030.7991@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58174 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751818Ab1H1Qy7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 12:54:59 -0400
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7SGsO9T013391
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 09:54:25 -0700
Received: by wwe5 with SMTP id 5so1787673wwe.1
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 09:54:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108281700030.7991@localhost6.localdomain6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Josh Triplett <josh@joshtriplett.org>

On Sun, Aug 28, 2011 at 7:01 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> It's lack of PSEUDO_SYM support. I haven't quite figured out what kind of
> code to generate for that because, frankly, I'm not completely sure what
> it's all about. ;-)

So "PSEUDO_SYM" is just a "link-time constant".

IOW, it's nothing but a pointer to an in-memory variable, and from a
code generation standpoint generating the symbol should be just about
the same as generating a constant, except rather than an actual value,
it's now a linker reference.

Of course, what complicates them is that you also need to generate the
symbol definition itself (somewhere else). In particular, the
sym->initializer points to the initializer of a symbol, and they can
be *complicated*. Generating the output for some symbols can be a
major pain in the *ss, just think about a complex structure array
initializer.

The PSEUDO_SYM you hit for the "hello world" program is trivial,
though. It's an unnamed symbol of type "char []", and it has a trivial
initializer (the string itself). So symbols can be hard to generate,
but there are simple cases.

So for a PSUEDO_SYM, you need to look up "struct symbol" for it
(pseudo->sym), which then has:

 - name of the symbol (sym->ident). Of course, some symbols don't have
names, like the constant string example.

 - type/size/alignment information (sym->ctype)

 - initializer information (sym->initializer - which can be a really
complex expression). Of course, for external symbols - or symbols with
no initializer - this is just empty.

There's way more to symbol types in sparse than that, but apart from
the initializer expression, most of the symbol complexity has been
handled by earlier stages (ie a *lot* of the front-end of sparse is
about symbols and their types).

                          Linus
