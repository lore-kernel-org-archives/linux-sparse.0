From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Tue, 9 Dec 2014 09:11:31 +0800
Message-ID: <CANeU7QnoNPbYsURU=4mJyGVHE2+CdxqFFdLA2TErD3JhAEqwqw@mail.gmail.com>
References: <5400357A.5050705@xs4all.nl>
	<CANeU7Q=q7AL=nh2BGfHyAYqjHbMu9cu3NbR7Jkfw4wd+SPRWUA@mail.gmail.com>
	<5481B580.3080100@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56461 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319AbaLIBLc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Dec 2014 20:11:32 -0500
Received: by mail-qa0-f53.google.com with SMTP id bm13so4135357qab.40
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2014 17:11:32 -0800 (PST)
In-Reply-To: <5481B580.3080100@xs4all.nl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Dec 5, 2014 at 9:39 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> Hi Chris,
>
> Any updates on this?
>

Well, I haven't fully understand the code that merge two sorted list in place.
It is that code that cause the sorting error. One quick and dirty way to fix it
is just convert the list with more than one bucket into an array then
use qsort()
on it. That will require modify the compare function and copy the list back from
the array.

Chris
