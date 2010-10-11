From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Mon, 11 Oct 2010 09:04:18 -0700
Message-ID: <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<1286710919.24953.2.camel@thorin>
	<201010101352.10864.kdudka@redhat.com>
	<1286790249.24953.14.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41265 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977Ab0JKQET convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 12:04:19 -0400
Received: by gyg13 with SMTP id 13so817995gyg.19
        for <linux-sparse@vger.kernel.org>; Mon, 11 Oct 2010 09:04:19 -0700 (PDT)
In-Reply-To: <1286790249.24953.14.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: Kamil Dudka <kdudka@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Oct 11, 2010 at 2:44 AM, Bernd Petrovitsch <bernd@sysprog.at> w=
rote:
> ---- =A0snip =A0----
> {102}egrep -wc 'false|true' *.[ch] | grep -v :0
> compile-i386.c:19
> evaluate.c:13
> expand.c:10
> flow.c:10
> inline.c:13
> linearize.c:6
> pre-process.c:3
> show-parse.c:3
> simplify.c:9
> symbol.c:1
> tokenize.c:1
> ---- =A0snip =A0----
> There are perhaps false positives in there - but not all.
>
> Perhaps 'sparse' should warn if one names variables, functions, and
> similar "true", "false" or with any other C99 keyword.
> For C++ keywords, a different option is probably best.
>

Those are not used in header files they should be fine. Sparse uses
C99 extensively
so it is likely it can't compile as C++ any way. I see no reason to
compile sparse
with C++.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
