From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse, llvm: fix link errors
Date: Wed, 15 May 2013 03:09:50 -0700
Message-ID: <51935EEE.2060407@chrisli.org>
References: <1368219684-4567-1-git-send-email-xi.wang@gmail.com> <518E8CEE.6060001@chrisli.org> <518EFA10.6040108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51306 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3EOKJ7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 May 2013 06:09:59 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so1358664pab.21
        for <linux-sparse@vger.kernel.org>; Wed, 15 May 2013 03:09:58 -0700 (PDT)
In-Reply-To: <518EFA10.6040108@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>

On 05/11/2013 07:10 PM, Xi Wang wrote:
> 
> This doesn't work for me.
> 
> The problem is that -ldl (`llvm --ldflags`) must come _after_
> -lLLVMSupport (`llvm --libs`).
> 
> Can we move LDFLAGS?
> 

Sorry for the late reply.

In that case, your first patch is actually cleaner.
I apply your first patch instead.  Change pushed.

BTW, Pekka, I notice that "sparse-llvm_EXTRA_DEPS" is redundant
with the next line, which also have sparse-llvm.o. Am I miss some
thing?

 sparse-llvm_EXTRA_DEPS := sparse-llvm.o
 sparse-llvm.o $(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)


Chris
