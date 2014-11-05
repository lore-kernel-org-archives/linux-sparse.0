From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Wed, 5 Nov 2014 18:49:23 +0800
Message-ID: <CANeU7QmfgPwOk0LMaUFxaH6UzA03NUizR6ybZ58NGkPEd3OkvQ@mail.gmail.com>
References: <5400357A.5050705@xs4all.nl>
	<5459D56E.3080704@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63286 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaKEKtZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Nov 2014 05:49:25 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so575634wgg.19
        for <linux-sparse@vger.kernel.org>; Wed, 05 Nov 2014 02:49:23 -0800 (PST)
In-Reply-To: <5459D56E.3080704@xs4all.nl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 5, 2014 at 3:44 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> Ping!
>
> This is still failing (tested with the latest sparse v0.5.0-35-gc1c3f96
> from git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git).
>
> I'd really like to get rid of these spurious sparse warnings.

Sorry I did not know this warning still exist. There have been some
fix for similar
warnings. I just confirm that your example reproduce the warning in my sparse
tree.

I will take a look.

Thanks

Chris
