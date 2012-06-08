From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 15:57:04 -0400
Message-ID: <BF377438-F907-4620-B1EA-55D91C6C674B@gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com> <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com> <CA+55aFyGWsjSqrAEvc=TL9qB0QabKuBaVx7ncABJ+A_McKY5wg@mail.gmail.com> <D19AC258-0412-4310-B2DE-A593F50203D4@gmail.com> <CA+55aFwCMtzW9e0J8zPnUZsBNmCMRPqsL+hpzkMp4nx4sMXbFw@mail.gmail.com> <CAOJsxLGEbCLu2AWS+tZJAnsCtg64N4y-+az0BSAXqaWiWVXd9w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:50325 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699Ab2FHT5J (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 15:57:09 -0400
Received: by ghrr11 with SMTP id r11so1544055ghr.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 12:57:09 -0700 (PDT)
In-Reply-To: <CAOJsxLGEbCLu2AWS+tZJAnsCtg64N4y-+az0BSAXqaWiWVXd9w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Jun 8, 2012, at 3:47 PM, Pekka Enberg wrote:
> Yeah. I'd really prefer we avoid any special tricks with LLVM and just
> do what clang does.

This is not really a special trick:

http://llvm.org/docs/GetElementPtr.html#int

I won't worry about optimizations; an alias analysis that takes care of
inttoptr/ptrtoint should work.

I agree that using getelementptr looks more llvm-ish anyway. :-)

- xi
