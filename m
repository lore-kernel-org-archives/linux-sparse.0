From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Mon, 29 Aug 2011 10:41:23 +0300
Message-ID: <CAOJsxLE-3CLPrLhphaVLs6CoWi0JYA02=Ny_fRrn8wqS2o0NcQ@mail.gmail.com>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>
	<CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com>
	<alpine.DEB.2.00.1108281700030.7991@localhost6.localdomain6>
	<CA+55aFymNRxwWMVPwhWKGB7T2UXduGccjW1FgKYGCb8QH9QAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42008 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab1H2HlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 03:41:24 -0400
Received: by gya6 with SMTP id 6so4563548gya.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 00:41:23 -0700 (PDT)
In-Reply-To: <CA+55aFymNRxwWMVPwhWKGB7T2UXduGccjW1FgKYGCb8QH9QAhg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Josh Triplett <josh@joshtriplett.org>

On Sun, Aug 28, 2011 at 7:01 AM, Pekka Enberg <penberg@kernel.org> wrot=
e:
>> It's lack of PSEUDO_SYM support. I haven't quite figured out what ki=
nd of
>> code to generate for that because, frankly, I'm not completely sure =
what
>> it's all about. ;-)

On Sun, Aug 28, 2011 at 7:54 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So "PSEUDO_SYM" is just a "link-time constant".
>
> IOW, it's nothing but a pointer to an in-memory variable, and from a
> code generation standpoint generating the symbol should be just about
> the same as generating a constant, except rather than an actual value=
,
> it's now a linker reference.
>
> Of course, what complicates them is that you also need to generate th=
e
> symbol definition itself (somewhere else). In particular, the
> sym->initializer points to the initializer of a symbol, and they can
> be *complicated*. Generating the output for some symbols can be a
> major pain in the *ss, just think about a complex structure array
> initializer.
>
> The PSEUDO_SYM you hit for the "hello world" program is trivial,
> though. It's an unnamed symbol of type "char []", and it has a trivia=
l
> initializer (the string itself). So symbols can be hard to generate,
> but there are simple cases.
>
> So for a PSUEDO_SYM, you need to look up "struct symbol" for it
> (pseudo->sym), which then has:
>
> =A0- name of the symbol (sym->ident). Of course, some symbols don't h=
ave
> names, like the constant string example.
>
> =A0- type/size/alignment information (sym->ctype)
>
> =A0- initializer information (sym->initializer - which can be a reall=
y
> complex expression). Of course, for external symbols - or symbols wit=
h
> no initializer - this is just empty.
>
> There's way more to symbol types in sparse than that, but apart from
> the initializer expression, most of the symbol complexity has been
> handled by earlier stages (ie a *lot* of the front-end of sparse is
> about symbols and their types).

Right. Will the "link time constant" 'struct symbol' be part of the
symbol_list? If it is, then we already do LLVMAddGlobal in
output_data() on it and could probably just stash that into a ->priv
member in 'struct symbol' and use that in pseudo_to_value().
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
