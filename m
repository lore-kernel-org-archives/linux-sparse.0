From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Sat, 02 Aug 2014 19:31:20 +0100
Message-ID: <53DD2E78.2050609@knosof.co.uk>
References: <20140731181006.GA13180@cloud>	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>	<CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>	<CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com> <CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:53897 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754675AbaHBSlO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 14:41:14 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 7A667400C54
	for <linux-sparse@vger.kernel.org>; Sat,  2 Aug 2014 19:34:06 +0100 (BST)
In-Reply-To: <CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Linus,

> .. and in fact I think even without those things, you can just make
> the unnamed union have a type name, ie
>
>     struct S {
>        union T {
>            int a;
>        }
>     };
>
> the union T has a typename, but is a unnamed member of struct S. We
> could use "union T" later.

No such luck, not allowed by the C Standard.

6.7.2.1p13
"An unnamed member whose type specifier is a structure specifier with
no tag is called an anonymous structure; an unnamed member whose type
specifier is a union specifier with no tag is called an anonymous union"

But you can do this sort of thing when the type specifier is not anonymous.

-- 
Derek M. Jones                  tel: +44 (0) 1252 520 667
Knowledge Software Ltd          blog:shape-of-code.coding-guidelines.com
Software analysis               http://www.knosof.co.uk
