From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Error handling in sparse-llvm
Date: Sun, 12 Mar 2017 20:53:16 +0100
Message-ID: <20170312195315.bdjcqd5guhvkwvfj@macpro.local>
References: <CACXZuxcU4ZQ0=D67F4EkqyFKANQVjhSxfSzsqdzXbNXYsGXGfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35873 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935396AbdCLTxU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 15:53:20 -0400
Received: by mail-wm0-f48.google.com with SMTP id n11so27226569wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 12:53:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcU4ZQ0=D67F4EkqyFKANQVjhSxfSzsqdzXbNXYsGXGfQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 07:40:18PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> At present there are a bunch of asserts for scenarios not handled by
> Sparse LLVM backend. A more robust error handling method is needed
> that works even in release builds, and doesn't abort the process.
> Given the way the code is structured currently, I was thinking maybe
> it will be easiest to use setjmp/longjmp mechanism to terminate the
> LLVM backend on error. I am not sure that this entirely safe with LLVM
> as the LLVM code is C++ - I think it might be okay as long as the LLVM
> module / context is properly disposed at the end.

By far, the best thing that can be done is to add support for the missing
features/scenarios so that those asserts can be removed. 

-- Luc Van Oostenryck
