From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 12:28:44 -0700
Message-ID: <CA+55aFwCMtzW9e0J8zPnUZsBNmCMRPqsL+hpzkMp4nx4sMXbFw@mail.gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
 <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com>
 <CA+55aFyGWsjSqrAEvc=TL9qB0QabKuBaVx7ncABJ+A_McKY5wg@mail.gmail.com> <D19AC258-0412-4310-B2DE-A593F50203D4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58391 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab2FHT3G (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 15:29:06 -0400
Received: by wgbdr13 with SMTP id dr13so1187044wgb.1
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 12:29:04 -0700 (PDT)
In-Reply-To: <D19AC258-0412-4310-B2DE-A593F50203D4@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Fri, Jun 8, 2012 at 12:25 PM, Xi Wang <xi.wang@gmail.com> wrote:
>
> What I am doing now is to convert all operands to integers first,
> perform the addition, and then convert the result back to pointer.
> Anything wrong with that?

Wrong with it? No, it's what all reasonable hardware does anyway. But
it's possible that it would effectively disable some LVM warnings or
optimizations.

             Linus
