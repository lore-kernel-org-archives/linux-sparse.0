From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 22:47:13 +0300
Message-ID: <CAOJsxLGEbCLu2AWS+tZJAnsCtg64N4y-+az0BSAXqaWiWVXd9w@mail.gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
	<56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com>
	<CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
	<CA+55aFyGWsjSqrAEvc=TL9qB0QabKuBaVx7ncABJ+A_McKY5wg@mail.gmail.com>
	<D19AC258-0412-4310-B2DE-A593F50203D4@gmail.com>
	<CA+55aFwCMtzW9e0J8zPnUZsBNmCMRPqsL+hpzkMp4nx4sMXbFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36956 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933432Ab2FHTrO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 15:47:14 -0400
Received: by vbbff1 with SMTP id ff1so1343990vbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 12:47:13 -0700 (PDT)
In-Reply-To: <CA+55aFwCMtzW9e0J8zPnUZsBNmCMRPqsL+hpzkMp4nx4sMXbFw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Fri, Jun 8, 2012 at 12:25 PM, Xi Wang <xi.wang@gmail.com> wrote:
>> What I am doing now is to convert all operands to integers first,
>> perform the addition, and then convert the result back to pointer.
>> Anything wrong with that?

On Fri, Jun 8, 2012 at 10:28 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Wrong with it? No, it's what all reasonable hardware does anyway. But
> it's possible that it would effectively disable some LVM warnings or
> optimizations.

Yeah. I'd really prefer we avoid any special tricks with LLVM and just
do what clang does.
