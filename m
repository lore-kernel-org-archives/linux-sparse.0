From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse, llvm: fix link errors
Date: Wed, 15 May 2013 15:02:32 +0300
Message-ID: <CAOJsxLH_o8aGA1a4QMcy4Z+e0CXsNSWrh1SEtbfiT9fYXGKx5A@mail.gmail.com>
References: <1368219684-4567-1-git-send-email-xi.wang@gmail.com>
	<518E8CEE.6060001@chrisli.org>
	<518EFA10.6040108@gmail.com>
	<51935EEE.2060407@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:62685 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758610Ab3EOMCd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 May 2013 08:02:33 -0400
Received: by mail-wi0-f179.google.com with SMTP id hq7so1528395wib.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 May 2013 05:02:32 -0700 (PDT)
In-Reply-To: <51935EEE.2060407@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Xi Wang <xi.wang@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, May 15, 2013 at 1:09 PM, Christopher Li <sparse@chrisli.org> wrote:
> BTW, Pekka, I notice that "sparse-llvm_EXTRA_DEPS" is redundant
> with the next line, which also have sparse-llvm.o. Am I miss some
> thing?
>
>  sparse-llvm_EXTRA_DEPS := sparse-llvm.o
>  sparse-llvm.o $(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)

No, I you're not missing anything. Feel free to drop it.
