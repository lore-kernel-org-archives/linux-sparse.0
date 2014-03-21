From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: preop expression and variable
Date: Fri, 21 Mar 2014 11:13:13 -0700
Message-ID: <CA+55aFxCVVdvrMRhOsmvAU-DqWQ8DRFBNohFWvn4HodHXA0U_A@mail.gmail.com>
References: <22AE7E9E-932B-4E83-9DE1-CE82FD140CDF@ygg.tf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:44329 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaCUSNO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 21 Mar 2014 14:13:14 -0400
Received: by mail-ve0-f176.google.com with SMTP id cz12so2883770veb.7
        for <linux-sparse@vger.kernel.org>; Fri, 21 Mar 2014 11:13:13 -0700 (PDT)
In-Reply-To: <22AE7E9E-932B-4E83-9DE1-CE82FD140CDF@ygg.tf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Guillaume_Oberl=C3=A9?= <goberle@ygg.tf>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Mar 21, 2014 at 4:02 AM, Guillaume Oberl=C3=A9 <goberle@ygg.tf>=
 wrote:
>
> If you look at the output (l117 or l133), I have a PreopExpression be=
fore every variable in an expression statement, even if I have no preop=
erator.

You need to look at what the op is too, not just the type.

I assume you're talking about EXPR_PREOP-'*'. That's a dereference
("lvalue access").  And yes, it's required. A symbol on its own is
just the address or the symbol. Actually *accessing* that symbol is
that PREOP-*.

            Lnus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
