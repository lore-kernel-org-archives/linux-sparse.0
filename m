From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] sparse, llvm: compile: skip function prototypes to
 avoid SIGSEGV
Date: Thu, 11 Jun 2015 17:50:16 -0700
Message-ID: <CANeU7Q=VgqNhSDdQzF1H0pUjs78axBGz0VLjG2RY80P6aFh-_A@mail.gmail.com>
References: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
	<1431815545-21250-2-git-send-email-a3at.mail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36453 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbFLAuR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Jun 2015 20:50:17 -0400
Received: by ykaz81 with SMTP id z81so10164514yka.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 Jun 2015 17:50:16 -0700 (PDT)
In-Reply-To: <1431815545-21250-2-git-send-email-a3at.mail@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Azat Khuzhin <a3at.mail@gmail.com>
Cc: Sparse ML <linux-sparse@vger.kernel.org>

On Sat, May 16, 2015 at 3:32 PM, Azat Khuzhin <a3at.mail@gmail.com> wrote:
>
> You can't pass function to LLVMConstNull(), according to
> Constant::getNullValue, and sparse-llvm already handle functions differently
> (i.e. there will be no call to LLVMConstNull(), but this is not true for


The patch looks good. I am applying it. However I just notice that you did not
provide the signed-off-by line.

Can you resend both patch with the signed off line?

Thanks

Chris
