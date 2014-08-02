From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Sat, 2 Aug 2014 11:10:59 -0700
Message-ID: <CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
	<CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
	<CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:57696 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbaHBSLA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 14:11:00 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so8697083vcb.23
        for <linux-sparse@vger.kernel.org>; Sat, 02 Aug 2014 11:10:59 -0700 (PDT)
In-Reply-To: <CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Aug 1, 2014 at 10:16 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Sorry I am late for the party. This approach assume the anonymous
> structure is only referenced inside the structure.

It does indeed. I thought that was ok.

> There is not other
> external reference. However, that assumption is not true if "-fplan9-extensions"
> or "-fms-extensions" was enabled. Sparse current does not support these
> two extensions. But it will be a problem if we support them down the road.

.. and in fact I think even without those things, you can just make
the unnamed union have a type name, ie

   struct S {
      union T {
          int a;
      }
   };

the union T has a typename, but is a unnamed member of struct S. We
could use "union T" later.

> Actually, the "find_identifier" call inside function "check_designators" already
> calculate the correct offset. Only if we can pass that offset to
> "convert_ident()".

I actually tried that initially, and wanted to get rid of the whole
"check_designators()" vs "convert_designators()", but couldn't really
find a sane way to make that work. I'll look at it again, maybe I
missed something.

             LInus
