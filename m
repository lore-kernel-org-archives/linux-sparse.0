From: Christopher Li <sparse@chrisli.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Sat, 2 Aug 2014 11:40:23 -0700
Message-ID: <CANeU7Qkrb-Q49JqpKy4fpBzFziCJxS_TCb22sxvpeGNrD6aqBQ@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
	<CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
	<CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com>
	<CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
	<53DD2E78.2050609@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:41098 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbaHBSkX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 14:40:23 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so7297659qgd.13
        for <linux-sparse@vger.kernel.org>; Sat, 02 Aug 2014 11:40:23 -0700 (PDT)
In-Reply-To: <53DD2E78.2050609@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 2, 2014 at 11:31 AM, Derek M Jones <derek@knosof.co.uk> wrote:
>> .. and in fact I think even without those things, you can just make
>> the unnamed union have a type name, ie
>>
>>     struct S {
>>        union T {
>>            int a;
>>        }
>>     };
>>
>> the union T has a typename, but is a unnamed member of struct S. We
>> could use "union T" later.
>
>
> No such luck, not allowed by the C Standard.
>
> 6.7.2.1p13
> "An unnamed member whose type specifier is a structure specifier with
> no tag is called an anonymous structure; an unnamed member whose type
> specifier is a union specifier with no tag is called an anonymous union"
>
> But you can do this sort of thing when the type specifier is not anonymous.

That is what I recall as well, not part of stander C. If you enable
the "-fplan9-extensions",
Linus' example can pass.

Chris
