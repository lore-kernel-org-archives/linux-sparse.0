From: Christopher Li <sparse@chrisli.org>
Subject: Re: enum warning patch (was Re: Defect in linearization of short
	circuit &&)
Date: Tue, 16 Feb 2010 14:44:08 -0800
Message-ID: <70318cbf1002161444m6daa6a9dh7f30d347b4e9ebbb@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com>
	 <70318cbf1002161136o56cd0494pc6a2e38e28f1729c@mail.gmail.com>
	 <201002162111.31449.kdudka@redhat.com>
	 <201002162118.28516.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:60655 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932978Ab0BPWoJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 17:44:09 -0500
Received: by qw-out-2122.google.com with SMTP id 5so862326qwi.37
        for <linux-sparse@vger.kernel.org>; Tue, 16 Feb 2010 14:44:09 -0800 (PST)
In-Reply-To: <201002162118.28516.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Feb 16, 2010 at 12:18 PM, Kamil Dudka <kdudka@redhat.com> wrote=
:
> I've just remembered. =A0There was problem on a 32bit system - 32 byt=
es before
> and 36 bytes after the patch applied...

Yes, size is one of the aspect. I am more worry about putting the enum
information
at the wrong place.

It is about the enum type. It should store in the type system. The
expression is one
level above the type system, it contain a ctype there.

I am much happier if that enum information can be reach from the
expr->ctype some how,
which I haven't find out yet.

While you are here. I have a question for you.

Most simple enum declare has very small set of values. So naturally I
might want to use
some thing smaller than int type to store the enum value. I can't find
a good way to play
well with the enum warnings.

If I use "char type" to store it. It trigger warning when you assign to=
 it.
If I use "enum foo_type type:8" to store it, it will use int type
alignment and padding which
defeat the purpose of using a smaller type.

Any suggestion?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
