From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 08 Jun 2012 16:09:11 -0400
Message-ID: <4FD25BE7.7010900@garzik.org>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com> <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com> <CAOJsxLEQhzNe2RNKW3RkDNkLbu3cszJfW0KzRq4oNRVaRXoP5Q@mail.gmail.com> <CA+55aFyGWsjSqrAEvc=TL9qB0QabKuBaVx7ncABJ+A_McKY5wg@mail.gmail.com> <D19AC258-0412-4310-B2DE-A593F50203D4@gmail.com> <CA+55aFwCMtzW9e0J8zPnUZsBNmCMRPqsL+hpzkMp4nx4sMXbFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46207 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759167Ab2FHUJP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 16:09:15 -0400
Received: by yhmm54 with SMTP id m54so1577785yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 13:09:15 -0700 (PDT)
In-Reply-To: <CA+55aFwCMtzW9e0J8zPnUZsBNmCMRPqsL+hpzkMp4nx4sMXbFw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On 06/08/2012 03:28 PM, Linus Torvalds wrote:
> On Fri, Jun 8, 2012 at 12:25 PM, Xi Wang<xi.wang@gmail.com>  wrote:
>>
>> What I am doing now is to convert all operands to integers first,
>> perform the addition, and then convert the result back to pointer.
>> Anything wrong with that?
>
> Wrong with it? No, it's what all reasonable hardware does anyway. But
> it's possible that it would effectively disable some LVM warnings or
> optimizations.

Yep.  That is the tradeoff.

	Jeff




