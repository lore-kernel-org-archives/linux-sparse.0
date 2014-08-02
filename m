From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Sat, 2 Aug 2014 13:09:02 -0700
Message-ID: <CA+55aFwXGioNQenk1gBPWrDpx2icmthpadTYO1uHzE5co0W4VA@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
	<CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
	<CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com>
	<CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
	<CA+55aFzWAZ-ZQ6DSvnj6vQnwCHyDX11an1nOAo43UGaLcfshwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:60660 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbaHBUJE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 16:09:04 -0400
Received: by mail-vc0-f179.google.com with SMTP id hq11so8814099vcb.10
        for <linux-sparse@vger.kernel.org>; Sat, 02 Aug 2014 13:09:02 -0700 (PDT)
In-Reply-To: <CA+55aFzWAZ-ZQ6DSvnj6vQnwCHyDX11an1nOAo43UGaLcfshwg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 2, 2014 at 12:53 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My stupid test-case is this incredibly hacky thing:

.. actually, that test-case wasn't the one that showed the original
problem, it just ends up testing many of the other cases, notably the
"next_designator() creates that unnamed union case".

The test-case that shows the problem this patch fixes is one that
actually names the unnamed union entry (so instead of the "{ 3 }"
initializer, it uses ".d=3" to initialize the entry in the unnamed
union.

Just to clarify. See the difference in code generation by
"test-linearize" for those two cases (ie "{3}" vs ".d=3" in the
initializer).

          Linus
